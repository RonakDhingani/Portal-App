import 'dart:async';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/global_value.dart';
import 'package:inexture/model/upcoming_birthday_model.dart';

import '../../../common_widget/api_url.dart';
import '../../../common_widget/app_colors.dart';
import '../../../common_widget/asset.dart';
import '../../../common_widget/text.dart';
import '../../../model/today_work_anniversary_model.dart';
import '../../../model/user_information_model.dart';
import '../../../services/api_function.dart';
import '../../../utils/utility.dart';

class CustomThirdDetailsHomeCard extends StatefulWidget {
  const CustomThirdDetailsHomeCard({
    super.key,
    this.todayWorkAnnivModel,
    this.upcomingBirthdayModel,
    required this.isWorkAnniv,
    required this.isUpcomingBDay,
    this.quotes,
  });

  final TodayWorkAnniversaryModel? todayWorkAnnivModel;
  final UpcomingBirthdayModel? upcomingBirthdayModel;
  final String? quotes;
  final bool isWorkAnniv;
  final bool isUpcomingBDay;

  @override
  State<CustomThirdDetailsHomeCard> createState() =>
      _CustomThirdDetailsHomeCardState();
}

class _CustomThirdDetailsHomeCardState
    extends State<CustomThirdDetailsHomeCard> {
  late PageController workAnnivController;
  late PageController upcomingBDayController;
  bool isLoading = false;

  Timer? _timerWorkAnniv;
  Timer? _timerUpcomingBDay;

  int _currentTodayWorkAnnivPage = 0;
  int _currentUpcomingBDayPage = 0;
  UserInformationModel? userInformationModel;

  @override
  void initState() {
    super.initState();
    workAnnivController = PageController();
    upcomingBDayController = PageController();
    _timerWorkAnniv =
        Timer.periodic(Duration(seconds: 5), _changePageWorkAnniv);
    _timerUpcomingBDay =
        Timer.periodic(Duration(seconds: 5), _changePageUpcomingBDay);
  }

  @override
  void dispose() {
    _timerWorkAnniv?.cancel();
    _timerUpcomingBDay?.cancel();
    workAnnivController.dispose();
    upcomingBDayController.dispose();
    super.dispose();
  }

  void _changePageWorkAnniv(Timer timer) {
    int length = widget.todayWorkAnnivModel?.data?.length ?? 0;

    if (length > 1 && workAnnivController.hasClients) {
      _currentTodayWorkAnnivPage = (_currentTodayWorkAnnivPage + 1) % length;

      workAnnivController.animateToPage(
        _currentTodayWorkAnnivPage,
        duration: Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    }
  }

  void _changePageUpcomingBDay(Timer timer) {
    int length = widget.upcomingBirthdayModel?.data?.length ?? 0;

    if (length > 1 && upcomingBDayController.hasClients) {
      _currentUpcomingBDayPage = (_currentUpcomingBDayPage + 1) % length;

      upcomingBDayController.animateToPage(
        _currentUpcomingBDayPage,
        duration: Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> getUserinfo(String id) async {
    ApiFunction.apiRequest(
        url: '${ApiUrl.userInformation}$id',
        method: 'GET',
        onSuccess: (response) {
          log('User Info API Response : ${response.data.toString()}');
          userInformationModel = UserInformationModel.fromJson(response.data);
          var userDetails = userInformationModel?.basicDetails;
          setState(() {
            isLoading = false;
          });
          Utility.userInfoSheet(
            profileImage: userDetails?.image,
            userNames:
                "${userDetails?.firstName?[0].toUpperCase()}${userDetails?.lastName?[0].toUpperCase()}",
            fullName: "${userDetails?.firstName} ${userDetails?.lastName}",
            team: userInformationModel?.team,
            designation: userInformationModel
                ?.basicDetails?.designationOuter?.designation,
            experience:
                "${userDetails?.experience?.year} Years ${userDetails?.experience?.month} Month",
            skype: userDetails?.contactUrl?.skype,
            email: userDetails?.email,
            gmail: userDetails?.contactUrl?.gmail,
            github: userDetails?.contactUrl?.github,
            gitlab: userDetails?.contactUrl?.gitlab,
            technology: userDetails?.technology,
            projects: userInformationModel?.project?.data,
            teamLead: userInformationModel?.leader,
            isBirthDay: false,
          );
        },
        onUnauthorized: (p0) {
          ApiFunction.refreshTokenApi().then(
            (value) => getUserinfo(id),
          );
        },
        onError: (response) {
          setState(() {
            isLoading = false;
          });
          log('Upcoming Leave API Response : ${response.data.toString()}');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Card(
                              margin: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  widget.todayWorkAnnivModel?.data?.isEmpty ==
                                          true
                                      ? Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 60.h,
                                                width: 60.w,
                                                child: SvgPicture.asset(
                                                  AssetImg.anniversaryImg,
                                                ),
                                              ),
                                              Text(
                                                AppString.noAnniversaryFound,
                                                textAlign: TextAlign.center,
                                                style: CommonText.style500S15
                                                    .copyWith(
                                                        color:
                                                            AppColors.blackk),
                                              ),
                                            ],
                                          ),
                                        )
                                      : PageView.builder(
                                          controller: workAnnivController,
                                          itemCount: widget.todayWorkAnnivModel
                                                  ?.data?.length ??
                                              0,
                                          physics: BouncingScrollPhysics(),
                                          onPageChanged: (value) {
                                            setState(() {
                                              _currentTodayWorkAnnivPage =
                                                  value;
                                            });
                                          },
                                          itemBuilder: (context, index) {
                                            var workAnnivDetails = widget
                                                .todayWorkAnnivModel
                                                ?.data?[index];
                                            return AnimatedBuilder(
                                              animation: workAnnivController,
                                              builder: (context, child) {
                                                double value = 0;
                                                if (workAnnivController
                                                    .position.haveDimensions) {
                                                  value = workAnnivController
                                                          .page! -
                                                      index;
                                                }
                                                value = value.clamp(-1, 1);
                                                double rotationY = value * -1;
                                                double scale = 0.7 +
                                                    (1 - value.abs()) * 0.3;
                                                return Transform(
                                                  transform: Matrix4.identity()
                                                    ..setEntry(3, 2, 0.0015)
                                                    ..rotateY(rotationY),
                                                  alignment: Alignment.center,
                                                  child: Transform.scale(
                                                    scale: scale,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        getUserinfo(
                                                            workAnnivDetails?.id
                                                                    .toString() ??
                                                                '');
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                              AssetImg
                                                                  .ribbonImg,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  SizedBox(),
                                                                  SizedBox(
                                                                    height:
                                                                        60.h,
                                                                    width: 60.w,
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      cacheManager:
                                                                          DefaultCacheManager(),
                                                                      imageUrl:
                                                                          workAnnivDetails?.image ??
                                                                              '',
                                                                      imageBuilder:
                                                                          (context,
                                                                              imageProvider) {
                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(workAnnivDetails?.image ?? ''),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          Utility
                                                                              .circleProcessIndicator(),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.yelloww,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            10,
                                                                          ),
                                                                        ),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "${workAnnivDetails?.firstName?[0].toUpperCase()}${workAnnivDetails?.lastName?[0].toUpperCase()}",
                                                                          style: CommonText
                                                                              .style600S18
                                                                              .copyWith(
                                                                            color:
                                                                                AppColors.whitee,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${workAnnivDetails?.firstName} ${workAnnivDetails?.lastName}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: CommonText
                                                                        .style500S15
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .blackk,
                                                                    ),
                                                                  ),
                                                                  SizedBox(),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                  widget.todayWorkAnnivModel?.data?.isEmpty ==
                                          true
                                      ? Container()
                                      : Positioned(
                                          top: 0.h,
                                          left: 0.w,
                                          right: 0.w,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h, horizontal: 8.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              AppString.workAnniversary,
                                              textAlign: TextAlign.center,
                                              style: CommonText.style500S12
                                                  .copyWith(
                                                color: AppColors.blackk,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            if (widget.isWorkAnniv)
                              Utility.shimmerLoading(
                                margin: EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Card(
                              margin: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  widget.upcomingBirthdayModel?.data?.isEmpty ==
                                          true
                                      ? Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 60.h,
                                                width: 60.w,
                                                child: SvgPicture.asset(
                                                  AssetImg.cakeUpcomingImg,
                                                ),
                                              ),
                                              Text(
                                                AppString.noUpcomingBirthday,
                                                textAlign: TextAlign.center,
                                                style: CommonText.style500S15
                                                    .copyWith(
                                                        color:
                                                            AppColors.blackk),
                                              ),
                                            ],
                                          ),
                                        )
                                      : PageView.builder(
                                          controller: upcomingBDayController,
                                          itemCount: widget
                                                  .upcomingBirthdayModel
                                                  ?.data
                                                  ?.length ??
                                              0,
                                          physics: BouncingScrollPhysics(),
                                          onPageChanged: (value) {
                                            setState(() {
                                              _currentUpcomingBDayPage = value;
                                            });
                                          },
                                          itemBuilder: (context, index) {
                                            var upcomingBDayDetails = widget
                                                .upcomingBirthdayModel
                                                ?.data?[index];
                                            return AnimatedBuilder(
                                              animation: upcomingBDayController,
                                              builder: (context, child) {
                                                double value = 0;
                                                if (upcomingBDayController
                                                    .position.haveDimensions) {
                                                  value = upcomingBDayController
                                                          .page! -
                                                      index;
                                                }
                                                value = value.clamp(-1, 1);
                                                double rotationY = value * -1;
                                                double scale = 0.7 +
                                                    (1 - value.abs()) * 0.3;
                                                return Transform(
                                                  transform: Matrix4.identity()
                                                    ..setEntry(3, 2, 0.0015)
                                                    ..rotateY(rotationY),
                                                  alignment: Alignment.center,
                                                  child: Transform.scale(
                                                    scale: scale,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        getUserinfo(
                                                            upcomingBDayDetails
                                                                    ?.id
                                                                    .toString() ??
                                                                '');
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                              AssetImg
                                                                  .ribbonImg,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  SizedBox(),
                                                                  SizedBox(
                                                                    height:
                                                                        60.h,
                                                                    width: 60.w,
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      cacheManager:
                                                                          DefaultCacheManager(),
                                                                      imageUrl:
                                                                          upcomingBDayDetails?.image ??
                                                                              '',
                                                                      imageBuilder:
                                                                          (context,
                                                                              imageProvider) {
                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(upcomingBDayDetails?.image ?? ''),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          Utility
                                                                              .circleProcessIndicator(),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.yelloww,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "${upcomingBDayDetails?.firstName?[0].toUpperCase()}${upcomingBDayDetails?.lastName?[0].toUpperCase()}",
                                                                          style: CommonText
                                                                              .style600S18
                                                                              .copyWith(
                                                                            color:
                                                                                AppColors.whitee,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${upcomingBDayDetails?.firstName} ${upcomingBDayDetails?.lastName}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: CommonText
                                                                        .style500S15
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .blackk,
                                                                    ),
                                                                  ),
                                                                  SizedBox(),
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 0.h,
                                                              left: 0.w,
                                                              right: 0.w,
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical: 5.h,
                                                                  horizontal:
                                                                      8.w,
                                                                ),
                                                                child: Text(
                                                                  Global
                                                                      .formatDateWithSuffix(
                                                                    "${upcomingBDayDetails?.birthDate}",
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: CommonText
                                                                      .style500S15
                                                                      .copyWith(
                                                                    color: AppColors
                                                                        .yelloww,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                  widget.upcomingBirthdayModel?.data?.isEmpty ==
                                          true
                                      ? Container()
                                      : Positioned(
                                          top: 0.h,
                                          left: 0.w,
                                          right: 0.w,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h, horizontal: 8.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              AppString.upcomingBirthday,
                                              textAlign: TextAlign.center,
                                              style: CommonText.style500S12
                                                  .copyWith(
                                                color: AppColors.blackk,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            if (widget.isUpcomingBDay)
                              Utility.shimmerLoading(
                                margin: EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isLoading)
                    Utility.circleProcessIndicator(
                        backgroundColor: AppColors.whitee)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 5, top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            widget.quotes ?? '',
                            textAlign: TextAlign.start,
                            textStyle: CommonText.style600S18.copyWith(
                              color: AppColors.greyy,
                              fontSize: 21,
                            ),
                            speed: Duration(milliseconds: 100),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (isLoading) ModalBarrier()
      ],
    );
  }
}
