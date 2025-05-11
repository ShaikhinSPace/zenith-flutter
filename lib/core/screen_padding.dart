import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// padding of body of scaffold
class ScreenPadding extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget child;

  const ScreenPadding({super.key, this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w),
      child: Center(child: child),
    );
  }
}
