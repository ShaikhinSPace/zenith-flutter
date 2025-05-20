import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zenith/common/widgets/normal_text_widget.dart';
import 'package:zenith/core/screen_padding.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Headline1Text(text: 'Session Screen')),
        body: ScreenPadding(
          child: Column(children: [Card(child: StopwatchWidget())]),
        ),
      ),
    );
  }
}

class StopwatchWidget extends StatefulWidget {
  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  // Use ValueNotifier<Duration> instead of ValueNotifier<int>
  final ValueNotifier<Duration> _elapsedTime = ValueNotifier<Duration>(
    Duration(),
  );
  late final Ticker _ticker;
  final ValueNotifier<bool> _isRunning = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_tick);
  }

  void _tick(Duration elapsed) {
    if (_isRunning.value) {
      _elapsedTime.value = elapsed;
    }
  }

  void _startStopwatch() {
    _isRunning.value = true;
    _ticker.start();
  }

  void _stopStopwatch() {
    _isRunning.value = false;
    _ticker.stop();
  }

  void _resetStopwatch() {
    _isRunning.value = false;
    _elapsedTime.value = Duration(); // Reset to 0
    _ticker.stop();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  // Method to format the Duration into HH:mm:ss.mmm format
  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(3, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder<Duration>(
          valueListenable: _elapsedTime,
          builder: (context, elapsedTime, child) {
            return Text(
              _formatDuration(elapsedTime),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            );
          },
        ),
        SizedBox(height: 20),
        ValueListenableBuilder<bool>(
          valueListenable: _isRunning,
          builder: (context, isRunning, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isRunning ? null : _startStopwatch,
                  child: Text('Start'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: isRunning ? _stopStopwatch : null,
                  child: Text('Stop'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
