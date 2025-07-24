// ignore_for_file: must_be_immutable


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/profile_image.dart';
import 'package:inexture/common_widget/text.dart';

import '../utils/utility.dart';
import 'app_colors.dart';
import 'app_string.dart';
import 'global_value.dart';
import 'request_component/lable_box_ui.dart';

class CommonListview extends StatelessWidget {
  CommonListview({
    super.key,
    required this.data,
    required this.fullDayCount,
    required this.halfDayCount,
    required this.total,
    required this.filter,
    required this.itemCount,
    this.onPageChanged,
    this.currentPage,
  });

  List data;
  String fullDayCount;
  String halfDayCount;
  String total;
  String filter;
  int itemCount;
  Function(int)? onPageChanged = (p0) {};
  ValueNotifier<int>? currentPage;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty == true
        ? Utility.dataNotFound()
        : Column(
            children: [
              Container(
                height: 60,
                margin: EdgeInsets.all(10),
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: onPageChanged,
                  children: [
                    LableBoxUi.labelBoxUi(
                      elevation: (filter == '') ? 2.0 : 1.0,
                      context: context,
                      title: AppString.total,
                      count: total,
                      color: AppColors.greenn,
                    ),
                    LableBoxUi.labelBoxUi(
                      elevation: (filter == AppString.full) ? 2.0 : 1.0,
                      context: context,
                      title: AppString.fullDay,
                      count: fullDayCount,
                      color: AppColors.blues,
                    ),
                    LableBoxUi.labelBoxUi(
                      elevation: (filter == AppString.half) ? 2.0 : 1.0,
                      context: context,
                      title: AppString.halfDay,
                      count: halfDayCount,
                      color: AppColors.redd,
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: currentPage ?? ValueNotifier<int>(0),
                builder: (context, value, child) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Builder(
                    builder: (context) {
                      List filteredData = filter != ''
                          ? data
                              .where(
                                  (userDetails) => userDetails.type == filter)
                              .toList()
                          : data;
                      return filteredData.isEmpty
                          ? Utility.dataNotFound()
                          : ListView.builder(
                              key: Key('commonListView'),
                              cacheExtent: 9999,
                              findChildIndexCallback: (key) {
                                final valueKey = key as ValueKey<String>;
                                return filteredData.indexWhere((holiday) =>
                                    'holiday-${holiday.id}' == valueKey.value);
                              },
                              padding: EdgeInsets.only(bottom: 20),
                              itemCount: filteredData.length,
                              itemBuilder: (context, index) {
                                var userDetails = filteredData[index];
                                var isRightOrLeft = (index % 2 == 0);

                                return FadeInUp(
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            child: ProfileImage(
                                              userName:
                                                  '${userDetails?.requestFrom?.firstName?[0].toUpperCase()}${userDetails?.requestFrom?.lastName?[0].toUpperCase()}',
                                              profileImage:
                                                  '${userDetails?.requestFrom?.image}',
                                              name: "${userDetails?.requestFrom?.firstName} ${userDetails?.requestFrom?.lastName}",
                                              radius: 25,
                                              borderWidth: 1,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${userDetails?.requestFrom?.firstName} ${userDetails?.requestFrom?.lastName}',
                                                        maxLines: 1,
                                                        style: CommonText
                                                            .style500S15
                                                            .copyWith(
                                                          color:
                                                              AppColors.blackk,
                                                        ),
                                                      ),
                                                      CommonText.richText(
                                                        fontSize: 13,
                                                        firstTitle:
                                                            '${userDetails?.duration}',
                                                        secTitle: ' ${AppString.day}',
                                                        color: AppColors.blackk,
                                                      ),
                                                    ],
                                                  ),
                                                  CommonText.richText(
                                                    fontSize: 13,
                                                    fontSize2: 13,
                                                    firstTitle: AppString.teamColan,
                                                    secTitle:
                                                        '${userDetails?.requestFrom?.userOfficialDetails?.team}',
                                                    color: AppColors.blackk,
                                                    firstColor: AppColors.blues,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: CommonText
                                                            .dateSmallRichText(
                                                          firstDate:
                                                              Global.formatDate(
                                                            '${userDetails?.startDate}',
                                                          ),
                                                          secDate:
                                                              Global.formatDate(
                                                            '${userDetails?.endDate}',
                                                          ),
                                                          dateColor:
                                                              AppColors.blackk,
                                                        ),
                                                      ),
                                                      // Spacer(),
                                                      Text(
                                                        userDetails.type.toString().capitalizeFirst ?? '',
                                                        style: CommonText
                                                            .style500S15
                                                            .copyWith(
                                                          color: userDetails
                                                                      .type ==
                                                              AppString.full
                                                              ? AppColors.blues
                                                              : AppColors.redd,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
