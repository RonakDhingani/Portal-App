// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/screen/time_entry/time_entry_details/component/time_entry_title_list.dart';

import '../../../../model/my_time_entry_month_model.dart';

class TimeEntryRow extends StatelessWidget {
  final String titleIn;
  final String titleOut;
  final List<Log> logIn;
  final List<Log> logOut;
  final Color color;

  const TimeEntryRow({
    super.key,
    required this.titleIn,
    required this.titleOut,
    required this.logIn,
    required this.logOut,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: TimeEntryTitleList(
              title: titleIn,
              color: color,
              log: logIn,
            ),
          ),
          VerticalDivider(indent: 45.h, endIndent: 10.h),
          Expanded(
            child: TimeEntryTitleList(
              title: titleOut,
              color: color,
              log: logOut,
            ),
          ),
        ],
      ),
    );
  }
}

