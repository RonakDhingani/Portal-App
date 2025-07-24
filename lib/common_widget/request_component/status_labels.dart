// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:inexture/common_widget/app_colors.dart';

import '../app_string.dart';
import 'lable_box_ui.dart';

class StatusLabels extends StatelessWidget {
  StatusLabels({
    super.key,
    required this.total,
    required this.approved,
    required this.pending,
    required this.cancelled,
    required this.rejected,
    required this.status,
     this.onPageChanged,
     this.currentPage,
     this.pageController,
  });

  String total;
  String approved;
  String pending;
  String cancelled;
  String rejected;
  String status;
  Function(int)? onPageChanged =(p0) {};
  ValueNotifier<int>? currentPage;
  PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 5),
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: onPageChanged,
            children: [
              LableBoxUi.labelBoxUi(
                elevation: (status == '') ? 2.0 : 1.0,
                context: context,
                title: AppString.totalRequest,
                color: AppColors.blues,
                count: total,
              ),
              LableBoxUi.labelBoxUi(
                elevation: (status == AppString.pending) ? 2.0 : 1.0,
                context: context,
                title: AppString.pendingC,
                color: AppColors.yellowLight,
                count: pending,
              ),
              LableBoxUi.labelBoxUi(
                elevation: (status == AppString.approvedSmall) ? 2.0 : 1.0,
                context: context,
                title: AppString.approved,
                color: AppColors.greenn,
                count: approved,
              ),
              LableBoxUi.labelBoxUi(
                elevation: (status == AppString.cancelled) ? 2.0 : 1.0,
                context: context,
                title: AppString.cancelledC,
                color: AppColors.yelloww,
                count: cancelled,
              ),
              LableBoxUi.labelBoxUi(
                elevation: (status == AppString.rejected) ? 2.0 : 1.0,
                context: context,
                title: AppString.rejectedC,
                color: AppColors.redd,
                count: rejected,
              ),
            ],
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: currentPage ?? ValueNotifier<int>(0),
          builder: (context, value, child) {
            return Container(
             margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: List.generate(
                    5, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value == index
                          ? AppColors.yelloww
                          : AppColors.greyy,
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}
