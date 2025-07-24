// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/common_dropdown_menu.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';

import '../common_widget/global_value.dart';
import '../controller/holidays_controller.dart';

class HolidaysScreen extends GetView<HolidaysController> {
  HolidaysScreen({super.key});

  @override
  final HolidaysController controller = Get.put(HolidaysController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HolidaysController>(
      builder: (holidaysController) {
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.holidays,
            widget: Row(
              children: [
                if(holidaysController.dropdownValue != '')
                CommonDropdownMenuForYear(
                  isDefaultSelected: holidaysController.isDefaultSelected,
                  dropdownValue: holidaysController.dropdownValue,
                  items: holidaysController.dropdownItems,
                  value: holidaysController.isDefaultSelected
                      ? null
                      : holidaysController.dropdownValue,
                  onChanged: (value) {
                    holidaysController.dropdownValue = value;
                    holidaysController.isDefaultSelected = false;
                    holidaysController.update();
                    if (value != null) {
                      List<String> parts = value.split(' - ');
                      if (parts.length == 2) {
                        holidaysController.startYear = parts[0];
                        holidaysController.endYear = parts[1];
                        holidaysController.getHolidays(isShowLoading: true);
                      }
                    }
                  },
                ),
                IconButton(
                  onPressed: () {
                    holidaysController.toggleLayout();
                  },
                  icon: Icon(
                    holidaysController.layoutType == LayoutType.listView
                        ? Icons.grid_view_outlined
                        : holidaysController.layoutType == LayoutType.gridView
                            ? Icons.list
                            : Icons.list_alt_outlined,
                    color: AppColors.whitee,
                  ),
                ),
              ],
            ),
          ),
          body: holidaysController.isLoading
              ? Utility.circleProcessIndicator()
              : holidaysController.statusCode == 500
                  ? Utility.errorMessage()
                  : holidaysController.holidaysResponse?.results?.isEmpty ==
                          true
                      ? Utility.dataNotFound()
                      : holidaysController.layoutType == LayoutType.listView
                          ? GridView.builder(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Two items per row
                                mainAxisSpacing: 10.h,
                                crossAxisSpacing: 10.w,
                              ),
                              itemCount: holidaysController
                                      .holidaysResponse?.results?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                var holidays = holidaysController
                                    .holidaysResponse?.results?[index];
                                return FadeInUp(
                                  child: holidayContainer(
                                    holidays: holidays,
                                    holidaysController: holidaysController,
                                  ),
                                );
                              },
                            )
                          : holidaysController.layoutType == LayoutType.gridView
                              ? ListView.builder(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 15),
                                  itemCount: holidaysController
                                          .holidaysResponse?.results?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    var holidays = holidaysController
                                        .holidaysResponse?.results?[index];
                                    return FadeInUp(
                                      child: ListTile(
                                        leading: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.blackk
                                                    .withOpacity(0.3),
                                                offset: Offset(0, 2),
                                                blurRadius: 2,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: CachedNetworkImage(
                                              cacheManager:
                                                  DefaultCacheManager(),
                                              fit: BoxFit.fill,
                                              imageUrl:
                                                  "${holidays?.holidayImage}",
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Utility.shimmerLoading(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          holidays?.name ?? AppString.happyHolidays,
                                          style:
                                              CommonText.style500S15.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                        ),
                                        subtitle: Text(
                                          holidaysController.formatDate(
                                            holidays?.date ?? '2024-04-19',
                                          ),
                                          style:
                                              CommonText.style500S12.copyWith(
                                            color: AppColors.greyyDark,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  key: Key('holidayListView'),
                                  cacheExtent: 9999,
                                  findChildIndexCallback: (key) {
                                    final valueKey = key as ValueKey<String>;
                                    return holidaysController
                                        .holidaysResponse?.results
                                        ?.indexWhere((holiday) =>
                                            'holiday-${holiday.id}' ==
                                            valueKey.value);
                                  },
                                  padding: EdgeInsets.only(bottom: 20),
                                  itemCount: holidaysController
                                          .holidaysResponse?.results?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    var holidays = holidaysController
                                        .holidaysResponse?.results?[index];
                                    return FadeInUp(
                                      child: holidayContainer(
                                        holidays: holidays,
                                        holidaysController: holidaysController,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                      ),
                                    );
                                  },
                                ),
        );
      },
    );
  }

  Widget holidayContainer(
      {var holidays, holidaysController, EdgeInsetsGeometry? margin}) {
    return Utility.cacheImageNetworkWithShimmerLoading(
      imageUrl: '${holidays?.holidayImage}',
      title: holidays?.name ?? AppString.happyHolidays,
      dateTitle: holidaysController.formatDate(
        holidays?.date ?? '2024-04-19',
      ),
      margin: margin,
    );
  }
}
