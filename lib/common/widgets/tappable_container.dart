import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/core/theme/app_colors.dart';

class TappableContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final ColorModel? color;
  final Function? onTap;
  const TappableContainer({
    super.key,
    required this.child,
    this.height,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: getColor(
            context: context,
            colorClass: color ?? AppColors.whiteColor,
          ),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        height: height ?? 200.h,
        width: double.infinity,
        child: Padding(padding: const EdgeInsets.all(12.0), child: child),
      ),
    );
  }
}
