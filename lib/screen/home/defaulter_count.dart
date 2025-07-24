import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/global_value.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/text.dart';
import '../../model/defaulter_count_model.dart';

class DefaulterCount extends StatelessWidget {
  const DefaulterCount({
    super.key,
    required this.categoryWiseCounts,
    required this.totalDefaulterCount,
  });

  final List<CategoryWiseCounts> categoryWiseCounts;
  final int totalDefaulterCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.commonAppBar(
        context: context,
        title: AppString.defaulterCount,
        widget: Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      ),
      body: totalDefaulterCount == 0
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.total0,
                    style: CommonText.style500S20.copyWith(
                      color: AppColors.greyy,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppString.wellDoneDc,
                    style: CommonText.style500S16.copyWith(
                      color: AppColors.blackk,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: ListView.builder(
                itemCount: categoryWiseCounts.length,
                itemBuilder: (context, index) {
                  var categoryDetails = categoryWiseCounts[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.whitee,
                            border: Border.all(
                                color: AppColors.greyy, width: 0.8.w),
                            borderRadius:
                                categoryDetails.defaulterData!.isEmpty
                                    ? BorderRadius.circular(12.r)
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(12.r),
                                        topRight: Radius.circular(12.r),
                                      ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  categoryDetails.categoryName ?? "",
                                  style: CommonText.style600S16.copyWith(
                                    color: AppColors.blackk,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: AppColors.yelloww.withOpacity(0.1),
                                  // borderRadius: BorderRadius.circular(20.r),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${categoryDetails.count}",
                                  style: CommonText.style600S16.copyWith(
                                    color: AppColors.yelloww,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: AppColors.whitee,
                          elevation: 2,
                          margin:
                              EdgeInsets.only(top: 0.h, left: 1.w, right: 1.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.r),
                              bottomRight: Radius.circular(12.r),
                            ),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                categoryDetails.defaulterData?.length ?? 0,
                            separatorBuilder: (_, __) => Divider(
                              height: 1.h,
                              color: AppColors.greyy.withOpacity(0.5),
                              indent: 16.w,
                              endIndent: 16.w,
                            ),
                            itemBuilder: (context, subIndex) {
                              var defaulterData =
                                  categoryDetails.defaulterData?[subIndex];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 22.r,
                                  backgroundColor:
                                      AppColors.redd.withOpacity(0.1),
                                  child: Icon(
                                    Icons.warning_rounded,
                                    color: AppColors.redd,
                                    size: 20.sp,
                                  ),
                                ),
                                title: Text(
                                  defaulterData?.reason?.name ??
                                      "Unknown Reason",
                                  style: CommonText.style500S15.copyWith(
                                    color: AppColors.blackk,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      Global.formatDateMonthYearName(
                                          "${defaulterData?.createdAt}"),
                                      style: CommonText.style500S13.copyWith(
                                        color: AppColors.greyyDark,
                                      ),
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 4.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
