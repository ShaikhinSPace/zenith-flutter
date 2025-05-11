import 'package:flutter/material.dart';
import 'package:zenith/common/widgets/normal_text_widget.dart';
import 'package:zenith/core/screen_padding.dart';

class SessionScreen extends StatefulWidget {
  final SessionType sessionType;
  const SessionScreen({super.key, required this.sessionType});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPadding(child: NormalTextWidget(text: 'Session Screen')),
    );
  }
}

enum SessionType { active, inactive }
