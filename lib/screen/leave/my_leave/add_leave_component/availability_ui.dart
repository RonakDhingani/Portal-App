import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:inexture/common_widget/app_string.dart';

import '../../../../common_widget/app_colors.dart';
import '../../../../common_widget/text.dart';

class AvailabilityUi extends StatelessWidget {
  const AvailabilityUi({
    super.key,
    required this.value,
    required this.onToggle,
    required this.title,
  });

  final bool value;
  final Function(bool) onToggle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FlutterSwitch(
            width: 55,
            height: 30,
            padding: 4,
            value: value,
            showOnOff: true,
            activeText: AppString.yes,
            valueFontSize: 11,
            inactiveText: AppString.no,
            onToggle: onToggle,
            activeColor: AppColors.yelloww,
            inactiveColor: AppColors.greyy,
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
      ),
    );
  }
}
