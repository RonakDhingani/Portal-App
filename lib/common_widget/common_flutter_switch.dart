import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/text.dart';

import 'app_colors.dart';

class CommonFlutterSwitch extends StatelessWidget {
  CommonFlutterSwitch({
    super.key,
    required this.value,
    required this.onToggle,
    required this.title,
    this.height,
    this.width,
    this.padding,
    this.toggleSize,
    this.activeText,
    this.inactiveText,
  });

  final bool value;
  final Function(bool) onToggle;
  final String title;
  double? height;
  double? width;
  double? padding;
  double? toggleSize;
  String? activeText;
  String? inactiveText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FlutterSwitch(
          width: width ?? 55.w,
          height: height ?? 30.h,
          padding: padding ?? 4.sp,
          toggleSize: toggleSize ?? 25.0.sp,
          value: value,
          showOnOff: true,
          activeText: activeText ?? AppString.yes,
          inactiveText: inactiveText ?? AppString.no,
          valueFontSize: 11,
          onToggle: onToggle,
          activeColor: AppColors.yelloww,
          inactiveColor: AppColors.greyy.withOpacity(0.4),
          activeTextColor: AppColors.whitee,
          inactiveTextColor: AppColors.blackk,
          activeTextFontWeight: FontWeight.w400,
          inactiveTextFontWeight: FontWeight.w400,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: CommonText.style500S15.copyWith(
            color: AppColors.blackk,
          ),
        ),
      ],
    );
  }
}
