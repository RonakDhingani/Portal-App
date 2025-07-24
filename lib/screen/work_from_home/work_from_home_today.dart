// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/app_string.dart';
import '../../common_widget/common_app_bar.dart';
import '../../common_widget/common_listview.dart';
import '../../controller/wrok_from_home_today_controller.dart';

class WorkFromHomeToday extends GetView<WorkFromHomeTodayController> {
  WorkFromHomeToday({super.key});

  @override
  WorkFromHomeTodayController controller =
      Get.put(WorkFromHomeTodayController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkFromHomeTodayController>(
      builder: (workFromHomeTodayController) {
        var dayTypeDetails =
            workFromHomeTodayController.workFromHomeTodayModel?.labels;
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.workFromHomeToday,
          ),
          body: CommonListview(
            data: workFromHomeTodayController.workFromHomeTodayModel?.result ??
                [],
            fullDayCount: dayTypeDetails?.fullDayCount.toString() ?? '0',
            halfDayCount: dayTypeDetails?.halfDayCount.toString() ?? '0',
            total: dayTypeDetails?.total.toString() ?? '0',
            itemCount: workFromHomeTodayController
                    .workFromHomeTodayModel?.result?.length ??
                0,
            filter: workFromHomeTodayController.filter,
            currentPage:
                ValueNotifier(workFromHomeTodayController.currentIndex),
            onPageChanged: (index) {
              workFromHomeTodayController.currentIndex = index;
              switch (index) {
                case 0:
                  return {
                    workFromHomeTodayController.filter = '',
                    workFromHomeTodayController.update(),
                  };
                case 1:
                  return {
                    workFromHomeTodayController.filter = AppString.full,
                    workFromHomeTodayController.update(),
                  };
                case 2:
                  return {
                    workFromHomeTodayController.filter = AppString.half,
                    workFromHomeTodayController.update(),
                  };
                default:
                  break;
              }
            },
          ),
        );
      },
    );
  }
}
