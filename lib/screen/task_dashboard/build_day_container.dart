import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/profile_image.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';

class BuildDayContainer extends StatelessWidget {
  BuildDayContainer({
    super.key,
    required this.day,
    this.totalHours,
    this.workLeaved,
    required this.isLoading,
    this.isToday,
    required this.bgColor,
    required this.textColor,
  });

  DateTime day;
  String? totalHours;
  String? workLeaved;
  bool isLoading;
  bool? isToday = false;
  Color bgColor;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: isToday == true
            ? AppColors.yelloww.withOpacity(0.2)
            : AppColors.transparent,
        border: Border.all(color: AppColors.greyy),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: isLoading == true
          ? Utility.shimmerLoading(
              borderRadius: BorderRadius.circular(6.0),
            )
          : Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 2, right: 2),
                    child: Row(
                      children: [
                        Visibility(
                          visible: workLeaved?.isNotEmpty == true,
                          replacement: Spacer(),
                          child: Container(
                            padding: EdgeInsets.only(left: 2, right: 2),
                            margin: EdgeInsets.only(left: 2, right: 2),
                            decoration: BoxDecoration(
                              color: AppColors.orangee,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Text(
                              "$workLeaved",
                              textAlign: TextAlign.center,
                              style: CommonText.style400S13.copyWith(
                                color: AppColors.whitee,
                                fontSize: 7.sp,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${day.day}',
                          style: CommonText.style500S13.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (totalHours !=
                    null) // Conditionally render the hours container
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 2, right: 2),
                          margin: EdgeInsets.only(left: 2, right: 2),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Text(
                            totalHours!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CommonText.style500S12.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
    );
  }
}
