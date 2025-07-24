// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/text.dart';

import '../global_value.dart';
import '../profile_image.dart';

class RequestDetailsTile extends StatelessWidget {
  RequestDetailsTile({
    super.key,
    this.firstName,
    this.lastName,
    this.image,
    required this.color,
    required this.leaveStatus,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.leaveType,
    this.monthlyWFH,
    required this.onTap,
    this.halfDayStatus,
    required this.commentsCount,
    required this.comments,
    this.isWorkFromHome,
  });

  String? firstName;
  String? lastName;
  String? image;
  Color? color;
  String? leaveStatus;
  String? startDate;
  String? endDate;
  String? duration;
  String? leaveType;
  String? monthlyWFH;
  String? halfDayStatus;
  String commentsCount;
  List<dynamic>? comments;
  Function()? onTap;
  bool? isWorkFromHome;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.whitee,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1 + 30,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (firstName?.isNotEmpty == true && lastName?.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.only(right: 5),
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.3,
                            color: AppColors.greyyDark,
                          ),
                        ),
                        child: ProfileImage(
                          userName:
                              "${firstName?[0].toUpperCase()}${lastName?[0].toUpperCase()}",
                          profileImage: "$image",
                          name: "$firstName $lastName",
                          isFromRequest: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.greyy.withOpacity(0.2),
                          border: Border.all(color: AppColors.greyyDark),
                        ),
                        child: Text(
                          '$firstName $lastName',
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.greyyDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  CommonText.richText(
                    firstTitle: AppString.durationColan,
                    secTitle: '$duration Days',
                    color: AppColors.blackk,
                  ),
                  Spacer(),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: color?.withOpacity(0.2),
                    ),
                    child: Text(
                      leaveStatus?.capitalizeFirst ?? '',
                      style: CommonText.style600S12.copyWith(
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              CommonText.dateRichText(
                dateColor: AppColors.yelloww,
                firstDate: '$startDate',
                secDate: '$endDate',
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${leaveType?.capitalizeFirst} Days',
                      style: CommonText.style500S15.copyWith(
                        color: leaveType == AppString.full
                            ? AppColors.blues
                            : AppColors.greenn,
                      ),
                    ),
                    Visibility(
                      visible: isWorkFromHome == true,
                      child: CommonText.richText(
                        firstTitle: AppString.monthlyWFHColan,
                        secTitle: '$monthlyWFH',
                        color: AppColors.blackk,
                      ),
                    ),
                    InkWell(
                      // splashColor: AppColors.transparent,
                      onTap: commentsCount == '0'
                          ? () {}
                          : () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 5,
                                      sigmaY: 5,
                                    ),
                                    child: AlertDialog(
                                      insetPadding: const EdgeInsets.all(15),
                                      contentPadding: const EdgeInsets.all(15),
                                      // backgroundColor: AppColors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      icon: Row(
                                        children: [
                                          Text(
                                            AppString.comments,
                                            style:
                                                CommonText.style600S16.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: SizedBox(
                                        height: 300.h,
                                        width: 300.w,
                                        child: ListView.builder(
                                          itemCount: comments?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            var cmtValue = comments?[index];
                                            return Card(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ProfileImage(
                                                      userName:
                                                      '${cmtValue.reviewBy?.firstName?[0].toUpperCase()}${cmtValue.reviewBy?.lastName?[0].toUpperCase()}',
                                                      profileImage: cmtValue.reviewBy?.image ?? '',
                                                      name: "${cmtValue.reviewBy?.firstName} ${cmtValue.reviewBy?.lastName}",
                                                      radius: 20,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${cmtValue?.reviewBy?.firstName} ${cmtValue?.reviewBy?.lastName}",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: CommonText.style500S15.copyWith(
                                                                  color: AppColors.blackk,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only( right: 5.w),
                                                                child: Text(
                                                                  "${cmtValue.status ?? AppString.pending}".capitalizeFirst.toString(),
                                                                  maxLines: 1,
                                                                  textAlign: TextAlign.start,
                                                                  style: CommonText.style500S13.copyWith(
                                                                    color: Global.getColorForStatus(
                                                                        status: cmtValue.status ??
                                                                            AppString.pending,
                                                                        isFromCmt:
                                                                            true),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 3.h),
                                                          CommonText.richText(
                                                            firstTitle: AppString.commentsColan,
                                                            secTitle: (cmtValue.comments ?? ""),
                                                            color: AppColors.blackk,
                                                            fontSize: 13,
                                                            fontSize2: 13,
                                                            firstColor: AppColors.blues,
                                                            maxLines: cmtValue.comments.length,
                                                          ),
                                                          SizedBox(height: 5.h),
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              Text(
                                                                Global.formatDateMonthNameAMPM(
                                                                    cmtValue
                                                                        .createdAt),
                                                                textAlign: TextAlign.end,
                                                                style: CommonText
                                                                    .style500S12
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .greyyDark,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                  5.h),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                      child: Row(
                        children: [
                          Icon(
                            TablerIcons.message,
                            color: AppColors.yelloww,
                          ),
                          Text(
                             "\t$commentsCount",
                            style: CommonText.style500S15.copyWith(
                              color: AppColors.blackk,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
