import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/app_string.dart';
import '../../common_widget/text.dart';
import '../../utils/utility.dart';

class TimeEntryPageView extends StatelessWidget {
  TimeEntryPageView({
    super.key,
    this.controller,
    this.onPageChanged,
    this.color,
    required this.lastDay,
    required this.currentWeek,
    required this.monthly,
    required this.isLoading,
  });

  PageController? controller;
  Color? color;
  Function(int)? onPageChanged;
  String lastDay;
  String currentWeek;
  String monthly;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w),
      height: 150.h,
      child: isLoading
          ? Utility.shimmerLoading(
              color: AppColors.greyy.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
            )
          : ListView(
              controller: controller,
              // onPageChanged: onPageChanged,
              children: [
                FadeInRightBig(
                  child: containerCustom(
                    icon: TablerIcons.calendar,
                    title: AppString.lastDay,
                    time: (lastDay == 'null' || lastDay == '0')
                        ? '0h 0m 0s'
                        : lastDay,
                    color: AppColors.redd,
                  ),
                ),
                FadeInLeftBig(
                  child: containerCustom(
                    icon: TablerIcons.calendar_week,
                    title: AppString.currentWeek,
                    time: (currentWeek == 'null' || currentWeek == '0')
                        ? '0h 0m 0s'
                        : currentWeek,
                    color: AppColors.yelloww,
                  ),
                ),
                FadeInUp(
                  child: containerCustom(
                    icon: TablerIcons.calendar_month,
                    title: AppString.monthly,
                    time: (monthly == 'null' || monthly == '0')
                        ? '0h 0m 0s'
                        : monthly,
                    color: AppColors.greenn,
                  ),
                ),
              ],
            ),
    );
  }

  static containerCustom({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
  }) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              textAlign: TextAlign.center,
              title,
              style: CommonText.style500S15.copyWith(
                color: AppColors.blackk,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              time,
              style: CommonText.style500S15.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
