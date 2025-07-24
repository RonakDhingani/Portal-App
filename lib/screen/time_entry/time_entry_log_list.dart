import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_string.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/global_value.dart';
import '../../common_widget/text.dart';
import '../../controller/time_format_controller.dart';

class TimeEntryLogList extends StatelessWidget {
  TimeEntryLogList({
    super.key,
    this.date,
    this.inTime,
    this.outTime,
    this.gameZone,
    required this.total,
    this.onTap,
  });

  String? date;
  String? inTime;
  String? outTime;
  String? gameZone;
  String total;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var timeFormatCtrl = Get.find<TimeFormatController>();
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.whitee,
        child: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date ?? '15-05-2024',
                    style: CommonText.style500S15.copyWith(
                      color: AppColors.blackk,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonText.richText(
                    firstTitle: AppString.inTimeColan,
                    secTitle: inTime ?? '09:02:35',
                    color: AppColors.yelloww,
                  ),
                  CommonText.richText(
                    firstTitle: AppString.outTimeColan,
                    secTitle: Global.formatTime(
                      time: outTime ?? '09:02:35',
                      showSeconds: true,
                      showAMPM: false,
                      showOriginal: !timeFormatCtrl.showOriginal.value,
                    ),
                    color: AppColors.yelloww,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppString.gameZone,
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                        Text(
                          gameZone ?? '00:00:00',
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: VerticalDivider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppString.total,
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                        Text(
                          total,
                          style: CommonText.style500S15.copyWith(
                            color: (total.compareTo('08:20:00') <= 0)
                                ? AppColors.redd
                                : AppColors.greenn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
