// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/common_listview.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../common_widget/app_string.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../controller/leave_today_controller.dart';

class LeaveToday extends GetView<LeaveTodayController> {
  LeaveToday({super.key});

  @override
  LeaveTodayController controller = Get.put(LeaveTodayController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveTodayController>(
      builder: (leaveTodayController) {
        var dayTypeDetails =
            leaveTodayController.employeeOnLeaveTodayModel?.labels;
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.employeeOnLeave,
          ),
          body: CommonListview(
            data: leaveTodayController.employeeOnLeaveTodayModel?.results ?? [],
            fullDayCount: dayTypeDetails?.fullDayCount.toString() ?? '0',
            halfDayCount: dayTypeDetails?.halfDayCount.toString() ?? '0',
            total: dayTypeDetails?.total.toString() ?? '0',
            itemCount: leaveTodayController
                    .employeeOnLeaveTodayModel?.results?.length ??
                0,
            filter: leaveTodayController.filter,
            currentPage:
            ValueNotifier(leaveTodayController.currentIndex),
            onPageChanged: (index) {
              leaveTodayController.currentIndex = index;
              switch (index) {
                case 0:
                  return {
                    leaveTodayController.filter = '',
                    leaveTodayController.update(),
                  };
                case 1:
                  return {
                    leaveTodayController.filter = AppString.full,
                    leaveTodayController.update(),
                  };
                case 2:
                  return {
                    leaveTodayController.filter = AppString.half,
                    leaveTodayController.update(),
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
