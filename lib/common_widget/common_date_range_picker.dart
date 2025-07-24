

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'app_colors.dart';
import 'app_string.dart';

class CommonDateRangePicker extends StatelessWidget {
  const CommonDateRangePicker({super.key, this.onSubmit});

  final Function(Object?)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: AppColors.transparent,
              child: SizedBox(
                height: 400.h,
                width: 350.w,
                child: SfDateRangePicker(
                  startRangeSelectionColor: AppColors.yelloww,
                  endRangeSelectionColor: AppColors.yelloww,
                  rangeSelectionColor:
                  AppColors.yelloww.withOpacity(0.1),
                  selectionShape:
                  DateRangePickerSelectionShape.rectangle,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: CommonText.style600S15.copyWith(
                      color: AppColors.blackk,
                    ),
                  ),
                  headerHeight: 60.0,
                  showActionButtons: true,
                  confirmText: AppString.confirm,
                  cancelText: AppString.cancel,
                  onCancel: () {
                    Get.back();
                  },
                  onSubmit: onSubmit,
                  selectionMode:
                  DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                    DateTime.utc(
                      DateTime.now().year,
                      DateTime.now().month,
                      01,
                    ),
                    DateTime.now().lastDayOfMonth(),
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: Icon(
        TablerIcons.calendar,
      ),
      color: AppColors.whitee,
    );
  }
}
