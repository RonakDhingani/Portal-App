import 'package:flutter/material.dart';
import 'package:inexture/common_widget/app_string.dart';

import '../../../../common_widget/app_colors.dart';
import '../../../../common_widget/text.dart';

class DayTypeUi extends StatelessWidget {
  const DayTypeUi({
    super.key,
    required this.groupValueDayType,
    required this.groupValueHalfTime,
    required this.onChangedDayType,
    required this.onChangedHalfTime,
    required this.visible,
  });

  final String groupValueDayType;
  final String groupValueHalfTime;
  final Function(String?) onChangedDayType;
  final Function(String?) onChangedHalfTime;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonText.requiredText(title: AppString.dayType),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: RadioListTile<String>(
                value: AppString.full,
                groupValue: groupValueDayType,
                onChanged: onChangedDayType,
                title: Text(
                  AppString.fullDay,
                  style: CommonText.style500S15.copyWith(
                    color: AppColors.blackk,
                  ),
                ),
                fillColor: WidgetStatePropertyAll(AppColors.yelloww),
              ),
            ),
            Flexible(
              child: RadioListTile(
                value: AppString.half,
                groupValue: groupValueDayType,
                onChanged: onChangedDayType,
                title: Text(
                  AppString.halfDay,
                  style: CommonText.style500S15.copyWith(
                    color: AppColors.blackk,
                  ),
                ),
                fillColor: WidgetStatePropertyAll(AppColors.yelloww),
              ),
            ),
          ],
        ),
        Visibility(
          visible: visible,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText.requiredText(title: AppString.halfTime),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: RadioListTile<String>(
                      value: AppString.firsthalf,
                      groupValue: groupValueHalfTime,
                      onChanged: onChangedHalfTime,
                      title: Text(
                        AppString.firstHalf,
                        style: CommonText.style500S15.copyWith(
                          color: AppColors.blackk,
                        ),
                      ),
                      fillColor: WidgetStatePropertyAll(AppColors.yelloww),
                    ),
                  ),
                  Flexible(
                    child: RadioListTile<String>(
                      value: AppString.secondhalf,
                      groupValue: groupValueHalfTime,
                      onChanged: onChangedHalfTime,
                      title: Text(
                        AppString.secondHalf,
                        style: CommonText.style500S15.copyWith(
                          color: AppColors.blackk,
                        ),
                      ),
                      fillColor: WidgetStatePropertyAll(AppColors.yelloww),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
