// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/routes/app_pages.dart';
import 'package:inexture/common_widget/button_ui.dart';
import 'package:inexture/utils/utility.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/app_string.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/global_value.dart';
import '../../../common_widget/text.dart';
import '../../../controller/game_zone_slot_booking_controller.dart';
import '../../../controller/time_format_controller.dart';

class GameZoneSlotBooking extends GetView<GameZoneSlotBookingController> {
  GameZoneSlotBooking({super.key});

  @override
  final GameZoneSlotBookingController controller =
      Get.put(GameZoneSlotBookingController());

  @override
  Widget build(BuildContext context) {
    var timeFormatCtrl = Get.find<TimeFormatController>();
    return GetBuilder<GameZoneSlotBookingController>(
      builder: (gZSBController) {
        return WillPopScope(
          onWillPop: () async {
            if (gZSBController.isUpdated) {
              Get.back(result: "Update something");
            } else {
              Get.back();
            }
            return false;
          },
          child: Scaffold(
            appBar: CommonAppBar.commonAppBar(
              context: context,
              title: AppString.bookGameZoneSlot,
              onPressed: () {
                if (gZSBController.isUpdated) {
                  Get.back(result: "Update something");
                } else {
                  Get.back();
                }
                return false;
              },
            ),
            body: gZSBController.isLoading
                ? Utility.circleProcessIndicator()
                : Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FadeInLeftBig(
                                      child: Row(
                                        children: [
                                          Icon(
                                            TablerIcons.crop_1_1_filled,
                                            color: AppColors.greyy,
                                          ),
                                          Text(
                                            AppString.expired,
                                            style:
                                                CommonText.style400S14.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FadeInDown(
                                      child: Row(
                                        children: [
                                          Icon(
                                            TablerIcons.crop_1_1_filled,
                                            color: AppColors.redd,
                                          ),
                                          Text(
                                            AppString.booked,
                                            style:
                                                CommonText.style400S14.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FadeInRightBig(
                                      child: Row(
                                        children: [
                                          Icon(
                                            TablerIcons.crop_1_1_filled,
                                            color: AppColors.greenn2,
                                          ),
                                          Text(
                                            AppString.available,
                                            style:
                                                CommonText.style400S14.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FadeInLeft(
                                      child: Row(
                                        children: [
                                          Icon(
                                            TablerIcons.crop_1_1_filled,
                                            color: AppColors.orangee,
                                          ),
                                          Text(
                                            AppString.meeting,
                                            style:
                                                CommonText.style400S14.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FadeInRight(
                                      child: Row(
                                        children: [
                                          Icon(
                                            TablerIcons.crop_1_1_filled,
                                            color: AppColors.blues,
                                          ),
                                          Text(
                                            AppString.mySlot,
                                            style:
                                                CommonText.style400S14.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "${AppString.game} - ${gZSBController.gameName}",
                          style: CommonText.style600S16.copyWith(
                            color: AppColors.greyyDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 15, right: 15, bottom: 20),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 50,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: gZSBController
                                    .gameZoneSlotBookingModel?.result?.length ??
                                0,
                            itemBuilder: (context, index) {
                              var slotDetails = gZSBController
                                  .gameZoneSlotBookingModel?.result?[index];
                              return GestureDetector(
                                onTap: (slotDetails?.idDisable == true ||
                                        (slotDetails?.mine == true
                                            ? slotDetails?.flag == 'available'
                                            : slotDetails?.flag == 'game'))
                                    ? null
                                    : (slotDetails?.mine == true ||
                                            slotDetails?.instance == userId)
                                        ? () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      15,
                                                    ),
                                                  ),
                                                  insetPadding:
                                                      EdgeInsets.all(20),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 20,
                                                    bottom: 0,
                                                  ),
                                                  actionsPadding:
                                                      EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 30,
                                                    top: 0,
                                                  ),
                                                  icon: Icon(
                                                    TablerIcons.info_circle,
                                                    color: AppColors.redd,
                                                    size: 100,
                                                  ),
                                                  title: Center(
                                                    child: Text(
                                                      AppString.deleteYourSlot,
                                                      style: CommonText
                                                          .style500S16
                                                          .copyWith(
                                                        color: AppColors.blackk,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  content: RichText(
                                                    maxLines: 5,
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              AppString.areYouSureYouWantTo,
                                                          style: CommonText
                                                              .style400S16
                                                              .copyWith(
                                                            color: AppColors
                                                                .greyyDark,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${AppString.deleteYourGameSlotFor} ${gZSBController.gameName} ${AppString.from} ${slotDetails?.startTime} ${AppString.to} ${slotDetails?.endTime}?",
                                                          style: CommonText
                                                              .style600S16
                                                              .copyWith(
                                                            color: AppColors
                                                                .blackk,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    ButtonUi(
                                                      onPressedSubmit: () {
                                                        Get.back();
                                                        gZSBController.slotDelete(
                                                            slotDetails
                                                                    ?.instance ??
                                                                0);
                                                      },
                                                      isEnable: true,
                                                      isLoading: false,
                                                      yes: AppString.confirm,
                                                      clr: AppColors.redd,
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        : () {
                                            Get.toNamed(
                                              Routes.gameBooking,
                                              arguments: {
                                                'gameIndex':
                                                    gZSBController.gameIndex,
                                                'gameName':
                                                    gZSBController.gameName,
                                                'startTimeUse':
                                                    slotDetails?.startTime,
                                                'endTimeUse':
                                                    slotDetails?.endTime,
                                                'startTime': Global.formatTime(
                                                  time:
                                                      '${slotDetails?.startTime}',
                                                  showSeconds: true,
                                                  showAMPM: false,
                                                  showOriginal: !timeFormatCtrl
                                                      .showOriginal.value,
                                                ),
                                                'endTime': Global.formatTime(
                                                  time:
                                                      '${slotDetails?.endTime}',
                                                  showSeconds: true,
                                                  showAMPM: false,
                                                  showOriginal: !timeFormatCtrl
                                                      .showOriginal.value,
                                                ),
                                              },
                                            )?.then((value) {
                                              if (value != null) {
                                                gZSBController.isUpdated = true;
                                                gZSBController
                                                    .getGamZoneSlotBooking();
                                              }
                                            });
                                          },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: slotDetails?.instance != null
                                            ? (slotDetails?.mine == true)
                                                ? AppColors.blues
                                                : slotDetails?.flag == 'meeting'
                                                    ? AppColors.orangee
                                                    : AppColors.redd
                                            : slotDetails?.idDisable == true
                                                ? AppColors.greyy
                                                : AppColors.greenn2,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          Global.formatTime(
                                            time: '${slotDetails?.startTime}',
                                            showSeconds: false,
                                            showAMPM: false,
                                            showOriginal: !timeFormatCtrl
                                                .showOriginal.value,
                                          ).substring(0, 5),
                                          style:
                                              CommonText.style500S15.copyWith(
                                            color: slotDetails?.idDisable ==
                                                    true
                                                ? AppColors.whitee
                                                : slotDetails?.instance != null
                                                    ? AppColors.whitee
                                                    : AppColors.blackk,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (slotDetails?.mine == true &&
                                        slotDetails?.idDisable == false)
                                      Positioned(
                                        right: 2,
                                        top: 2,
                                        child: Icon(
                                          TablerIcons.trash,
                                          color: AppColors.whitee,
                                          size: 20,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
