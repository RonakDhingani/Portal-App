// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:inexture/screen/venue_booking/game_zone/game_zone_ui_component/game_zone_list_tile.dart';
import 'package:inexture/utils/utility.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/app_string.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/text.dart';
import '../../../controller/game_zone_controller.dart';
import '../../../controller/time_format_controller.dart';
import '../../../routes/app_pages.dart';

class GameZone extends GetView<GameZoneController> {
  GameZone({super.key});

  @override
  final GameZoneController controller = Get.put(GameZoneController());

  @override
  Widget build(BuildContext context) {
    var timeFormatCtrl = Get.find<TimeFormatController>();
    return GetBuilder<GameZoneController>(
      builder: (gameZoneCtrl) {
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.venueBooking,
          ),
          body: gameZoneCtrl.isLoading
              ? Utility.circleProcessIndicator()
              : Column(
                  children: [
                    TabBar(
                      labelStyle: CommonText.style500S15,
                      unselectedLabelStyle: CommonText.style500S15
                          .copyWith(color: AppColors.blackk),
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.yelloww,
                          ),
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.yelloww,
                      dividerColor: AppColors.transparent,
                      padding: EdgeInsets.only(bottom: 10),
                      controller: gameZoneCtrl.controller,
                      tabs: gameZoneCtrl.myTabs,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: gameZoneCtrl.controller,
                        children: [
                          gameZoneCtrl.gamZoneBookedSlotModel?.results
                                      ?.isEmpty ==
                                  true
                              ? Utility.dataNotFound()
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                    right: 5,
                                  ),
                                  child: ListView.builder(
                                    itemCount: gameZoneCtrl
                                            .gamZoneBookedSlotModel
                                            ?.results
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      var gameDetails = gameZoneCtrl
                                          .gamZoneBookedSlotModel
                                          ?.results?[index];

                                      final status =
                                          gameZoneCtrl.getVenueStatus(
                                        gameDetails?.startTime ?? "00:00:00",
                                        gameDetails?.endTime ?? "00:00:00",
                                      );

                                      final isDisable =
                                          status == MeetingStatus.disabled;
                                      final isOnGoing =
                                          status == MeetingStatus.ongoing;

                                      return GameZoneListTile(
                                        useNameForImg:
                                            '${gameDetails?.createdBy?.firstName?[0].toUpperCase()}${gameDetails?.createdBy?.lastName?[0].toUpperCase()}',
                                        useName:
                                            "${gameDetails?.createdBy?.firstName} ${gameDetails?.createdBy?.lastName}",
                                        areaOrGameName:
                                            "${gameDetails?.game?.name}",
                                        proImg:
                                            "${gameDetails?.createdBy?.userImage}",
                                        bookingDate: "${gameDetails?.date}",
                                        onGoingTitle: AppString.playing,
                                        isDisable: isDisable,
                                        isOnGoing: isOnGoing,
                                        employees: gameDetails?.employees ?? [],
                                        isShowStackImg:
                                            gameDetails == 0 ? false : true,
                                        onTap: () {
                                          Utility.venueBookedSlotDetails(
                                            title:  AppString.gameColan,
                                            titleName:
                                                "${gameDetails?.game?.name}",
                                            playerOrEmployee: AppString.players,
                                            startTime:
                                                "${gameDetails?.startTime}",
                                            endTime: "${gameDetails?.endTime}",
                                            duration:
                                                "${gameDetails?.duration}",
                                            hostOrCreatedBy: AppString.createdBy,
                                            hostOrCreatedByName:
                                                "${gameDetails?.createdBy?.firstName} ${gameDetails?.createdBy?.lastName}",
                                            teamsName: "",
                                            podsName: "",
                                            employeesName:
                                                gameDetails?.employees
                                                        ?.map(
                                                          (e) =>
                                                              '${e.firstName} ${e.lastName}',
                                                        )
                                                        .join(', ') ??
                                                    '',
                                            maxLines: 3,
                                            maxLinesForTeams: 0,
                                            maxLinesForPods: 0,
                                            showOriginal: !timeFormatCtrl
                                                .showOriginal.value,
                                            showTeams: false,
                                            showPods: false,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                          gameZoneCtrl.meetingSlotBookedModel?.results
                                      ?.isEmpty ==
                                  true
                              ? Utility.dataNotFound()
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                    right: 5,
                                  ),
                                  child: ListView.builder(
                                    itemCount: gameZoneCtrl
                                            .meetingSlotBookedModel
                                            ?.results
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      var meetingDetails = gameZoneCtrl
                                          .meetingSlotBookedModel
                                          ?.results?[index];
                                      var employeesLength =
                                          meetingDetails?.employees?.length;
                                      var employeesName = meetingDetails
                                              ?.employees
                                              ?.map((e) =>
                                                  "${e.firstName} ${e.lastName}")
                                              .join(', ') ??
                                          "";
                                      final status =
                                          gameZoneCtrl.getVenueStatus(
                                        meetingDetails?.startTime ?? "00:00:00",
                                        meetingDetails?.endTime ?? "00:00:00",
                                      );

                                      final isDisable =
                                          status == MeetingStatus.disabled;
                                      final isOnGoing =
                                          status == MeetingStatus.ongoing;

                                      return GameZoneListTile(
                                        useNameForImg:
                                            '${meetingDetails?.createdBy?.firstName?[0].toUpperCase()}${meetingDetails?.createdBy?.lastName?[0].toUpperCase()}',
                                        useName:
                                            "${meetingDetails?.createdBy?.firstName} ${meetingDetails?.createdBy?.lastName}",
                                        areaOrGameName:
                                            "${meetingDetails?.meetingAreaName}",
                                        proImg:
                                            "${meetingDetails?.createdBy?.userImage}",
                                        bookingDate: "${meetingDetails?.date}",
                                        onGoingTitle: AppString.onGoing,
                                        isDisable: isDisable,
                                        isOnGoing: isOnGoing,
                                        employees:
                                            meetingDetails?.employees ?? [],
                                        isShowStackImg:
                                            employeesLength == 0 ? false : true,
                                        onTap: () {
                                          Utility.venueBookedSlotDetails(
                                            title: AppString.meetingAreaColan,
                                            titleName:
                                                "${meetingDetails?.meetingAreaName}",
                                            playerOrEmployee: AppString.employeeS,
                                            startTime:
                                                "${meetingDetails?.startTime}",
                                            endTime:
                                                "${meetingDetails?.endTime}",
                                            duration:
                                                "${meetingDetails?.duration}",
                                            hostOrCreatedBy: AppString.hostedBy,
                                            hostOrCreatedByName:
                                                "${meetingDetails?.createdBy?.firstName} ${meetingDetails?.createdBy?.lastName}",
                                            teamsName: meetingDetails?.teams
                                                    ?.map(
                                                      (e) => '${e.name}',
                                                    )
                                                    .join(', ') ??
                                                '',
                                            podsName: meetingDetails?.pods
                                                    ?.map(
                                                      (e) => '${e.name}',
                                                    )
                                                    .join(', ') ??
                                                '',
                                            employeesName: employeesName,
                                            maxLines: employeesLength == 0
                                                ? 1
                                                : employeesLength ?? 0,
                                            maxLinesForTeams:
                                                meetingDetails?.teams?.length ??
                                                    0,
                                            maxLinesForPods:
                                                meetingDetails?.pods?.length ??
                                                    0,
                                            showOriginal: !timeFormatCtrl
                                                .showOriginal.value,
                                            showTeams: meetingDetails
                                                    ?.teams?.isNotEmpty ==
                                                true,
                                            showPods: meetingDetails
                                                    ?.pods?.isNotEmpty ==
                                                true,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
          floatingActionButton: gameZoneCtrl.controller.index == 1
              ? FloatingActionButton(
                  elevation: 3.0,
                  backgroundColor: AppColors.yelloww,
                  shape: CircleBorder(),
                  onPressed: () {
                    Get.toNamed(Routes.meetingSlotBooking)?.then((value) {
                      if (value != null) {
                        gameZoneCtrl.isLoading = false;
                        gameZoneCtrl.update();
                        gameZoneCtrl.getMeetingBookedSlot();
                      }
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: AppColors.blackk,
                  ),
                )
              : SpeedDial(
                  backgroundColor: AppColors.yelloww,
                  icon: Icons.add,
                  activeIcon: Icons.close,
                  iconTheme: IconThemeData(
                    color: AppColors.blackk,
                  ),
                  spacing: 3,
                  childPadding: const EdgeInsets.all(5),
                  spaceBetweenChildren: 4,
                  direction: SpeedDialDirection.up,
                  heroTag: 'speed-dial-hero-tag',
                  elevation: 3.0,
                  animationCurve: Curves.elasticInOut,
                  isOpenOnStart: false,
                  children: gameZoneCtrl.gameZoneGamesModel
                          ?.map(
                            (game) => SpeedDialChild(
                              shape: CircleBorder(),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image: NetworkImage(game.image ?? ''),
                                ),
                              ),
                              backgroundColor: AppColors.whitee,
                              onTap: () {
                                Get.toNamed(Routes.gameZoneSlotBooking,
                                    arguments: {
                                      'gameIndex': game.id,
                                      'gameName': game.name
                                    })?.then(
                                  (value) {
                                    if (value != null) {
                                      gameZoneCtrl.getGameZoneBookedSlot(
                                          isShowLoading: true);
                                    }
                                  },
                                );
                              },
                            ),
                          )
                          .toList() ??
                      [],
                ),
        );
      },
    );
  }
}
