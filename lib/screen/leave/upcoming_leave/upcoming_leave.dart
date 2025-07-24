// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widget/app_string.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/common_listview.dart';
import '../../../controller/upcoming_leave_controller.dart';

class UpcomingLeave extends GetView<UpcomingLeaveController> {
  UpcomingLeave({super.key});

  @override
  UpcomingLeaveController controller = Get.put(UpcomingLeaveController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpcomingLeaveController>(
      builder: (upcomingLeaveController) {
        var dayTypeDetails = upcomingLeaveController.upcomingLeaveModel?.labels;
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.upcomingLeave,
          ),
          body: CommonListview(
            data: upcomingLeaveController.upcomingLeaveModel?.results ?? [],
            fullDayCount: dayTypeDetails?.fullDayCount.toString() ?? '0',
            halfDayCount: dayTypeDetails?.halfDayCount.toString() ?? '0',
            total: dayTypeDetails?.total.toString() ?? '0',
            itemCount:
                upcomingLeaveController.upcomingLeaveModel?.results?.length ??
                    0,
            filter: upcomingLeaveController.filter,
            currentPage: ValueNotifier(upcomingLeaveController.currentIndex),
            onPageChanged: (index) {
              upcomingLeaveController.currentIndex = index;
              switch (index) {
                case 0:
                  return {
                  upcomingLeaveController.filter = '',
                  upcomingLeaveController.update(),
                  };
                case 1:
                  return {
                  upcomingLeaveController.filter = AppString.full,
                  upcomingLeaveController.update(),
                  };
                case 2:
                  return {
                  upcomingLeaveController.filter = AppString.half,
                  upcomingLeaveController.update(),
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
