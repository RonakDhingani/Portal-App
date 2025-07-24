import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/model/today_birthday_model.dart';

import '../../../common_widget/api_url.dart';
import '../../../common_widget/app_colors.dart';
import '../../../common_widget/asset.dart';
import '../../../common_widget/global_value.dart';
import '../../../common_widget/text.dart';
import '../../../model/employee_of_the_month_model.dart';
import '../../../model/user_information_model.dart';
import '../../../services/api_function.dart';
import '../../../utils/utility.dart';

class CustomSecondDetailsHomeCard extends StatefulWidget {
  const CustomSecondDetailsHomeCard({
    super.key,
    required this.teamStrength,
    this.eomModel,
    this.todayBirthdayModel,
    required this.isEOM,
    required this.isTodayBDay,
    required this.isTeamStatus,
    required this.isDefaulter,
    required this.onTeamStatus,
    required this.onDefaulter,
  });

  final String teamStrength;
  final EmployeeOfTheMonthModel? eomModel;
  final TodayBirthdayModel? todayBirthdayModel;
  final bool isEOM;
  final bool isTodayBDay;
  final bool isTeamStatus;
  final bool isDefaulter;
  final Function()? onTeamStatus;
  final Function()? onDefaulter;

  @override
  State<CustomSecondDetailsHomeCard> createState() =>
      _CustomSecondDetailsHomeCardState();
}

class _CustomSecondDetailsHomeCardState
    extends State<CustomSecondDetailsHomeCard> {
  late PageController pageController;
  late PageController birthDayController;
  bool isLoading = false;
  Timer? _timer;
  Timer? _timerBirthDay;
  int _currentPage = 0;
  int _currentBirthDayPage = 0;
  UserInformationModel? userInformationModel;
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    pageController = PageController();
    birthDayController = PageController();
    _timer = Timer.periodic(Duration(seconds: 5), _changePage);
    _timerBirthDay = Timer.periodic(Duration(seconds: 5), _changePageBirthDay);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerBirthDay?.cancel();
    pageController.dispose();
    birthDayController.dispose();
    super.dispose();
  }

  void _changePage(Timer timer) {
    final length = widget.eomModel?.data?.length ?? 0;

    if (length > 1 && pageController.hasClients) {
      _currentPage = (_currentPage + 1) % length;

      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    }
  }

  void _changePageBirthDay(Timer timer) {
    int length = widget.todayBirthdayModel?.data?.length ?? 0;

    if (length > 1 && birthDayController.hasClients) {
      _currentBirthDayPage = (_currentBirthDayPage + 1) % length;

      birthDayController.animateToPage(
        _currentBirthDayPage,
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
          log('User Info API Response Success: ${response.data.toString()}');
          userInformationModel = UserInformationModel.fromJson(response.data);
          var userDetails = userInformationModel?.basicDetails;
          setState(() {
            isLoading = false;
          });
          Utility.userInfoSheet(
            confettiController: confettiController,
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
            isBirthDay: widget.todayBirthdayModel?.data?.isNotEmpty == true &&
                widget.todayBirthdayModel!.data!.any(
                    (e) => e.firstName.toString() == userDetails?.firstName),
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
          log('User Info API Response Error: ${response.data.toString()}');
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
                            GestureDetector(
                              onTap: widget.onTeamStatus,
                              child: Card(
                                margin: EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(),
                                    Icon(
                                      Icons.groups_outlined,
                                      size: 35,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          AppString.yourTeamStatus,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style:
                                              CommonText.style500S15.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                        ),
                                        Text(
                                          "${AppString.strength}: ${widget.teamStrength}",
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style:
                                              CommonText.style400S14.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (widget.isTeamStatus)
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
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: widget.eomModel?.data?.length ?? 0,
                                physics: BouncingScrollPhysics(),
                                onPageChanged: (value) {
                                  setState(() {
                                    _currentPage = value;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  var eomDetails =
                                      widget.eomModel?.data?[index];
                                  return AnimatedBuilder(
                                    animation: pageController,
                                    builder: (context, child) {
                                      double value = 0;
                                      if (pageController
                                          .position.haveDimensions) {
                                        value = pageController.page! - index;
                                      }
                                      value = value.clamp(-1, 1);
                                      double rotationY = value * -1;
                                      double scale =
                                          0.7 + (1 - value.abs()) * 0.3;
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
                                              getUserinfo(eomDetails?.user?.id
                                                      .toString() ??
                                                  '');
                                            },
                                            child: Stack(
                                              children: [
                                                if (eomDetails?.eomImage
                                                        ?.isNotEmpty ==
                                                    true)
                                                  CachedNetworkImage(
                                                    cacheManager:
                                                        DefaultCacheManager(),
                                                    imageUrl:
                                                        eomDetails!.eomImage!,
                                                    imageBuilder: (context,
                                                        imageProvider) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            // safer than reusing NetworkImage
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    placeholder: (context,
                                                            url) =>
                                                        Utility
                                                            .circleProcessIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error_outline,
                                                      color: AppColors.whitee,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )
                                                else
                                                  Center(
                                                    child: Icon(
                                                      Icons.image_not_supported,
                                                      color:
                                                          AppColors.greyyDark,
                                                    ),
                                                  ),
                                                Positioned(
                                                  top: 2.h,
                                                  left: 2.w,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.h,
                                                            horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.whitee
                                                          .withOpacity(0.9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      Global.getMonthName(
                                                          eomDetails?.month ??
                                                              0),
                                                      style: CommonText
                                                          .style500S15
                                                          .copyWith(
                                                        color: AppColors.blackk,
                                                      ),
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
                            if (widget.isEOM)
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
              child: Row(
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
                          child: widget.todayBirthdayModel?.data?.isEmpty ==
                                  true
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 60.h,
                                        width: 60.w,
                                        child: SvgPicture.asset(
                                          AssetImg.cakeImg,
                                        ),
                                      ),
                                      Text(
                                        AppString.noBirthdayToday,
                                        style: CommonText.style500S15
                                            .copyWith(color: AppColors.blackk),
                                      ),
                                    ],
                                  ),
                                )
                              : PageView.builder(
                                  controller: birthDayController,
                                  itemCount:
                                      widget.todayBirthdayModel?.data?.length ??
                                          0,
                                  physics: BouncingScrollPhysics(),
                                  onPageChanged: (value) {
                                    setState(() {
                                      _currentBirthDayPage = value;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    var todayBDayDetails =
                                        widget.todayBirthdayModel?.data?[index];
                                    return AnimatedBuilder(
                                      animation: birthDayController,
                                      builder: (context, child) {
                                        double value = 0;
                                        if (birthDayController
                                            .position.haveDimensions) {
                                          value =
                                              birthDayController.page! - index;
                                        }
                                        value = value.clamp(-1, 1);
                                        double rotationY = value * -1;
                                        double scale =
                                            0.7 + (1 - value.abs()) * 0.3;
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
                                                getUserinfo(todayBDayDetails?.id
                                                        .toString() ??
                                                    '');
                                              },
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      AssetImg.bdaysCeleImg,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 14.h, left: 6.w),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: SizedBox(
                                                          width: 76.w,
                                                          height: 76.h,
                                                          child: (todayBDayDetails
                                                                      ?.image
                                                                      ?.isNotEmpty ??
                                                                  false)
                                                              ? CachedNetworkImage(
                                                                  cacheManager:
                                                                      DefaultCacheManager(),
                                                                  imageUrl:
                                                                      todayBDayDetails!
                                                                          .image!,
                                                                  imageBuilder:
                                                                      (context,
                                                                          imageProvider) {
                                                                    return CircleAvatar(
                                                                      backgroundImage:
                                                                          imageProvider,
                                                                    );
                                                                  },
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Utility
                                                                          .circleProcessIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      fallbackInitials(
                                                                          todayBDayDetails),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : fallbackInitials(
                                                                  todayBDayDetails),
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
                        ),
                        if (widget.isTodayBDay)
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
                        GestureDetector(
                          onTap: widget.onDefaulter,
                          child: Card(
                            margin: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(),
                                Icon(
                                  TablerIcons.clock_record,
                                  size: 35,
                                ),
                                Text(
                                  AppString.yourDefaulterStatus,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: CommonText.style500S15.copyWith(
                                    color: AppColors.blackk,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (widget.isDefaulter)
                          Utility.shimmerLoading(
                            margin: EdgeInsets.all(5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (isLoading) ModalBarrier()
      ],
    );
  }

  Widget fallbackInitials(dynamic details) {
    final first = details?.firstName?.isNotEmpty == true
        ? details!.firstName![0].toUpperCase()
        : '';
    final last = details?.lastName?.isNotEmpty == true
        ? details!.lastName![0].toUpperCase()
        : '';

    return Container(
      width: 76.w,
      height: 76.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.whitee,
        shape: BoxShape.circle,
      ),
      child: Text(
        "$first $last",
        style: CommonText.style700S13.copyWith(
          fontSize: 20,
          color: AppColors.yelloww,
        ),
      ),
    );
  }
}
