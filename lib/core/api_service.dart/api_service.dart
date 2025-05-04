import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:zenith/core/di/di.dart';
import 'package:intl/intl.dart';

class StudySession {
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBreak;

  StudySession({
    required this.subject,
    required this.startTime,
    required this.endTime,
    this.isBreak = false,
  });

  int get durationInMinutes => endTime.difference(startTime).inMinutes;

  factory StudySession.fromJson(Map<String, dynamic> json) {
    return StudySession(
      subject: json['subject'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isBreak: json['isBreak'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isBreak': isBreak,
    };
  }
}

// models/schedule_request.dart
class ScheduleRequest {
  final DateTime startTime;
  final DateTime endTime;
  final List<String> subjects;
  final bool includePomodoro;
  final int? workDurationMinutes;
  final int? breakDurationMinutes;

  ScheduleRequest({
    required this.startTime,
    required this.endTime,
    required this.subjects,
    this.includePomodoro = true,
    this.workDurationMinutes = 25,
    this.breakDurationMinutes = 5,
  });

  String toPrompt() {
    final duration = endTime.difference(startTime).inMinutes;
    final startTimeStr =
        '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    final endTimeStr =
        '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';

    String prompt = '''
Create a detailed study schedule from $startTimeStr to $endTimeStr (total $duration minutes) for the following subjects: ${subjects.join(', ')}.
${includePomodoro ? 'Use the Pomodoro technique with $workDurationMinutes minutes of focused work and $breakDurationMinutes minute breaks.' : 'Create an efficient schedule with appropriate breaks.'}
Return the response as a JSON array of study sessions with this format:
[
  {
    "subject": "Subject Name",
    "startTime": "ISO datetime",
    "endTime": "ISO datetime",
    "isBreak": false
  },
  ...
]
Make sure each session has specific start and end times in ISO format, and use the actual subject names I provided.
''';
    return prompt;
  }
}

Dio dio =
    dio
      ..options = BaseOptions(
        connectTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 3000),
      );

class OpenRouterService {
  final String apiKey;
  final String siteUrl;
  final String siteName;

  OpenRouterService({
    this.apiKey =
        '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',
    this.siteUrl = '',
    this.siteName = '',
  });

  Future<String> getCompletion(
    String prompt, {
    String model = 'openai/gpt-4o',
  }) async {
    // final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    try {
      final response = await dio.post(
        'https://openrouter.ai/api/v1/chat/completions',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
            if (siteUrl.isNotEmpty) 'HTTP-Referer': siteUrl,
            if (siteName.isNotEmpty) 'X-Title': siteName,
          },
        ),
        data: jsonEncode({
          'model': model,
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.data);
        return jsonResponse['choices'][0]['message']['content'];
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }
}

class ScheduleGeneratorService {
  final OpenRouterService _openRouterService;

  ScheduleGeneratorService(this._openRouterService);

  Future<List<StudySession>> generateSchedule(ScheduleRequest request) async {
    try {
      // Generate the prompt for the AI
      final prompt = request.toPrompt();

      // Get completion from OpenRouter
      final response = await _openRouterService.getCompletion(prompt);

      // Extract JSON array from response
      String jsonStr = response;

      // Sometimes the AI might return markdown with code blocks or extra text,
      // so we need to extract just the JSON part
      final jsonRegExp = RegExp(r'\[[\s\S]*\]');
      final match = jsonRegExp.firstMatch(jsonStr);
      if (match != null) {
        jsonStr = match.group(0)!;
      }

      // Parse the JSON array
      final List<dynamic> sessionsJson = jsonDecode(jsonStr);

      // Convert to StudySession objects
      return sessionsJson.map((json) => StudySession.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to generate schedule: $e');
    }
  }
}

class AiScheduleScreen extends StatefulWidget {
  @override
  _AiScheduleScreenState createState() => _AiScheduleScreenState();
}

class _AiScheduleScreenState extends State<AiScheduleScreen> {
  final _scheduleService = ScheduleGeneratorService(OpenRouterService());

  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(Duration(hours: 3));
  List<String> _subjects = ['Math', 'Physics', 'Chemistry'];
  bool _usePomodoro = true;
  int _workDuration = 25;
  int _breakDuration = 5;

  bool _isLoading = false;
  List<StudySession> _generatedSessions = [];
  String _errorMessage = '';

  Future<void> _generateSchedule() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final request = ScheduleRequest(
        startTime: _startTime,
        endTime: _endTime,
        subjects: _subjects,
        includePomodoro: _usePomodoro,
        workDurationMinutes: _workDuration,
        breakDurationMinutes: _breakDuration,
      );

      final sessions = await _scheduleService.generateSchedule(request);

      setState(() {
        _generatedSessions = sessions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final initialTime = TimeOfDay.fromDateTime(isStart ? _startTime : _endTime);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        final now = DateTime.now();
        final newDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (isStart) {
          _startTime = newDateTime;
          // If end time is before start time, adjust it
          if (_endTime.isBefore(_startTime)) {
            _endTime = _startTime.add(Duration(hours: 1));
          }
        } else {
          _endTime = newDateTime;
          // If end time is before start time, adjust start time
          if (_endTime.isBefore(_startTime)) {
            _startTime = _endTime.subtract(Duration(hours: 1));
          }
        }
      });
    }
  }

  void _addSubject() {
    showDialog(
      context: context,
      builder: (context) {
        String newSubject = '';
        return AlertDialog(
          title: Text('Add Subject'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter subject name'),
            onChanged: (value) {
              newSubject = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newSubject.isNotEmpty) {
                  setState(() {
                    _subjects.add(newSubject);
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _removeSubject(int index) {
    setState(() {
      _subjects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Study Schedule Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Study Time Range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Start Time'),
                    subtitle: Text(DateFormat('h:mm a').format(_startTime)),
                    onTap: () => _selectTime(true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('End Time'),
                    subtitle: Text(DateFormat('h:mm a').format(_endTime)),
                    onTap: () => _selectTime(false),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subjects',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: _addSubject),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                _subjects.length,
                (index) => Chip(
                  label: Text(_subjects[index]),
                  deleteIcon: Icon(Icons.close, size: 18),
                  onDeleted: () => _removeSubject(index),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Pomodoro Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Use Pomodoro Technique'),
              value: _usePomodoro,
              onChanged: (value) {
                setState(() {
                  _usePomodoro = value;
                });
              },
            ),
            if (_usePomodoro) ...[
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Work Duration (min)'),
                      trailing: DropdownButton<int>(
                        value: _workDuration,
                        items:
                            [15, 20, 25, 30, 35, 40, 45, 50].map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _workDuration = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Break Duration (min)'),
                      trailing: DropdownButton<int>(
                        value: _breakDuration,
                        items:
                            [5, 10, 15, 20].map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _breakDuration = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _generateSchedule,
                child:
                    _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Generate AI Schedule'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
              ),
            SizedBox(height: 16),
            Expanded(
              child:
                  _generatedSessions.isEmpty
                      ? Center(
                        child: Text(
                          _isLoading
                              ? 'Generating schedule...'
                              : 'Your schedule will appear here',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _generatedSessions.length,
                        itemBuilder: (context, index) {
                          final session = _generatedSessions[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            color:
                                session.isBreak
                                    ? Colors.green[50]
                                    : Colors.blue[50],
                            child: ListTile(
                              leading: Icon(
                                session.isBreak ? Icons.coffee : Icons.school,
                                color:
                                    session.isBreak
                                        ? Colors.green
                                        : Colors.blue,
                              ),
                              title: Text(
                                session.isBreak ? 'Break' : session.subject,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${DateFormat('h:mm a').format(session.startTime)} - ${DateFormat('h:mm a').format(session.endTime)}'
                                '\n${session.durationInMinutes} minutes',
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
