// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';

import '../../../../common_widget/global_value.dart';
import '../../../../common_widget/text.dart';
import '../../../../controller/time_entry_controller.dart';
import '../../../../controller/time_format_controller.dart';
import '../../../../model/my_time_entry_month_model.dart';

class TimeEntryTitleList extends StatelessWidget {
  final String title;
  final List<Log> log;
  final Color color;

  const TimeEntryTitleList({
    super.key,
    required this.title,
    required this.color,
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    var timeFormatCtrl = Get.find<TimeFormatController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: CommonText.style500S16.copyWith(
            color: AppColors.blackk,
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(
          log.length,
          (index) {
            final timeEntryCtrl = Get.put(TimeEntryController());
            final logEntry = log[index];
            final borderProps = timeEntryCtrl.getBorderProperties(index, log.length);
            final borderRadius = borderProps['borderRadius'];
            return  Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: LinearGradient(
                    colors: [color, AppColors.greyy],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: Text(
                  Global.formatTime(
                    time: logEntry.time.toString(),
                    showSeconds: true,
                    showOriginal: !timeFormatCtrl.showOriginal.value,
                  ),
                  style: CommonText.style500S15,
                ),
              );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
