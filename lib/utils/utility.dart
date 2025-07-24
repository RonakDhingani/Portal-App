// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/buttons.dart';
import 'package:inexture/common_widget/textfield.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widget/asset.dart';
import '../common_widget/global_value.dart';
import '../common_widget/profile_image.dart';
import '../common_widget/text.dart';
import '../controller/main_home_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/task_dashboard_controller.dart';
import '../model/stored_user_model.dart';
import '../model/user_information_model.dart';
import '../routes/app_pages.dart';

class Utility {
  static Widget? hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return null;
  }

  static errorMessage() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_rounded,
            size: 40,
            color: AppColors.redd,
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            AppString.somethingWentWrongPlsTryAgnLtr,
            textAlign: TextAlign.center,
            style: CommonText.style500S15.copyWith(
              color: AppColors.blackk,
            ),
          ),
        ],
      ),
    );
  }

  static circleProcessIndicator(
      {Color? color, Color? backgroundColor, double? strokeWidth}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 3.0,
          color: color ?? AppColors.yelloww,
        ),
      ),
    );
  }

  static cupertinoProcessIndicator({Color? color, double? strokeWidth}) {
    return Align(
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(
        // radius: 3,
        color: color ?? AppColors.yelloww,
      ),
    );
  }

  static dataNotFound() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(Get.context!).size.width * 0.5,
            width: MediaQuery.of(Get.context!).size.width * 0.5,
            child: Lottie.asset(
              AssetLotties.noDataLottie,
              repeat: false,
              decoder: LottieComposition.decodeGZip,
            ),
          ),
          Text(
            AppString.noRecordsToFound,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: CommonText.style500S20.copyWith(
              color: AppColors.greyyDark,
            ),
          ),
        ],
      ),
    );
  }

  static Widget shimmerLoading({
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    Color? color,
    required BorderRadiusGeometry borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Shimmer.fromColors(
          baseColor: color ?? AppColors.transparent,
          highlightColor: AppColors.whitee.withValues(alpha: 0.1),
          child: Container(
            margin: margin,
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: color ?? AppColors.whitee,
              borderRadius: borderRadius,
            ),
          ),
        ),
      ),
    );
  }

  static Future userInfoSheet({
    final String? profileImage,
    final String? userNames,
    final String? fullName,
    final String? team,
    final String? designation,
    final String? experience,
    final String? skype,
    final String? email,
    final String? gmail,
    final String? github,
    final String? gitlab,
    final List<String>? technology,
    List<Data>? projects,
    List<Leader>? teamLead,
    ConfettiController? confettiController,
    required bool isBirthDay,
  }) async {
    PageController pageController = PageController();
    ValueNotifier<int> currentPage = ValueNotifier<int>(0);
    Widget buildContactRow(
        IconData icon, String title, String value, Color colors) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: colors,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CommonText.style600S15
                        .copyWith(color: AppColors.greyyDark),
                  ),
                  Text(
                    value,
                    style: CommonText.style400S15
                        .copyWith(color: AppColors.blackk),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final ConfettiController localConfettiController = confettiController ??
        ConfettiController(duration: const Duration(seconds: 3));

    if (isBirthDay == true) {
      localConfettiController.play();
    }

    await Get.bottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: AppColors.whitee,
      SizedBox(
        height: MediaQuery.of(Get.context!).size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.maximize_rounded,
                    size: 50.sp,
                    color: AppColors.greyyDark,
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.greyy,
                            width: 2,
                          ),
                        ),
                        child: ProfileImage(
                          userName: userNames ?? "",
                          profileImage: profileImage ?? "",
                          name: fullName ?? "",
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            fullName ?? "",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackk,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.yelloww),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  team ?? '',
                                  maxLines: 2,
                                  style: CommonText.style500S13
                                      .copyWith(color: AppColors.yelloww),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.greenn,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  experience ?? '',
                                  maxLines: 2,
                                  style: CommonText.style500S13,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.blackk),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              designation ?? '',
                              maxLines: 2,
                              style: CommonText.style500S13
                                  .copyWith(color: AppColors.blackk),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: localConfettiController,
                      blastDirection: -pi / 2,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: false,
                      emissionFrequency: 0.01,
                      numberOfParticles: 15,
                      maxBlastForce: 20,
                      minBlastForce: 15,
                      gravity: 0.3,
                      colors: const [
                        AppColors.greenn,
                        AppColors.blues,
                        AppColors.pinkk,
                        AppColors.orangee,
                        AppColors.purplee,
                        AppColors.yelloww,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.greyyDark),
            const SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  color: AppColors.transparent,
                  height: MediaQuery.of(Get.context!).size.height * 0.8,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      currentPage.value = index;
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppString.contact,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.blackk,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (email != null)
                            buildContactRow(
                              TablerIcons.mail,
                              AppString.email,
                              email,
                              AppColors.redd,
                            ),
                          if (gmail != null)
                            buildContactRow(
                              TablerIcons.brand_gmail,
                              AppString.gmail,
                              gmail,
                              AppColors.blackk,
                            ),
                          if (skype != null)
                            buildContactRow(
                              TablerIcons.brand_skype,
                              AppString.skype,
                              skype,
                              AppColors.blues,
                            ),
                          if (github != null)
                            buildContactRow(
                              TablerIcons.brand_github,
                              AppString.gitHub,
                              github,
                              AppColors.greyyDark,
                            ),
                          if (gitlab != null)
                            buildContactRow(
                              TablerIcons.brand_gitlab,
                              AppString.gitlab,
                              gitlab,
                              AppColors.orangee,
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppString.projects,
                                style: CommonText.style700S13.copyWith(
                                    color: AppColors.blackk, fontSize: 18),
                              ),
                            ],
                          ),
                          Flexible(
                            child: projects?.isEmpty == true
                                ? dataNotFound()
                                : ListView.separated(
                                    itemCount: projects?.length ?? 0,
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                    itemBuilder: (context, index) {
                                      var proDetails = projects?[index];
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${proDetails?.projectName}',
                                              style: CommonText.style600S16
                                                  .copyWith(
                                                color: AppColors.yelloww,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            CommonText.richText(
                                              firstTitle: AppString.codeColan,
                                              secTitle:
                                                  "${proDetails?.projectCode}",
                                              color: AppColors.blackk,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            CommonText.richText(
                                              firstTitle: AppString
                                                  .currentProjectStatusIsColan,
                                              secTitle:
                                                  "${proDetails?.status?.name}",
                                              color:
                                                  proDetails?.status?.color ==
                                                          "#21a357"
                                                      ? AppColors.greenn
                                                      : AppColors.redd,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            CommonText.richText(
                                              firstTitle: AppString
                                                  .designationNameColan,
                                              secTitle:
                                                  "${proDetails?.designation?.resourceDesignationName}",
                                              color:
                                                  proDetails?.status?.color ==
                                                          "#21a357"
                                                      ? AppColors.greenn
                                                      : AppColors.redd,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppString.skills,
                                style: CommonText.style700S13.copyWith(
                                    color: AppColors.blackk, fontSize: 18),
                              ),
                            ],
                          ),
                          Flexible(
                            child: technology?.isEmpty == true
                                ? Text(
                                    AppString.userHaveNotAddedAnySkillsYet,
                                    style: CommonText.style500S15.copyWith(
                                      color: AppColors.greyyDark,
                                    ),
                                  )
                                : GridView.builder(
                                    padding: EdgeInsets.only(bottom: 20),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 50,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: technology?.length,
                                    itemBuilder: (context, index) {
                                      var skills = technology?[index];
                                      return Container(
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.greyyDark),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Animate(
                                          effects: [
                                            ShimmerEffect(
                                              color: AppColors.yelloww,
                                              duration: Duration(seconds: 5),
                                            ),
                                          ],
                                          onComplete: (controller) {
                                            controller.repeat();
                                          },
                                          child: Text(
                                            '$skills',
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style:
                                                CommonText.style400S13.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ).animate().shimmer(),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppString.reportTo,
                                style: CommonText.style700S13.copyWith(
                                    color: AppColors.blackk, fontSize: 18),
                              ),
                            ],
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: teamLead?.length,
                              itemBuilder: (context, index) {
                                var tLDetails = teamLead?[index];
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 5),
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 1.3,
                                                color: AppColors.greyyDark,
                                              ),
                                            ),
                                            child: ProfileImage(
                                              userName:
                                                  "${tLDetails?.firstName?[0].toUpperCase()}${tLDetails?.lastName?[0].toUpperCase()}",
                                              profileImage:
                                                  "${tLDetails?.userImage}",
                                              name:
                                                  "${tLDetails?.firstName} ${tLDetails?.lastName}",
                                              radius: 15,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColors.greyy
                                                  .withValues(alpha: 0.2),
                                              border: Border.all(
                                                  color: AppColors.greyyDark),
                                            ),
                                            child: Text(
                                              '${tLDetails?.firstName} ${tLDetails?.lastName}',
                                              style: CommonText.style500S15
                                                  .copyWith(
                                                color: AppColors.greyyDark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: currentPage,
              builder: (context, value, child) {
                return Padding(
                  padding: EdgeInsets.only(bottom: Platform.isIOS ? 30 : 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: 8,
                        height: 8,
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
        ),
      ),
    );
  }

  static cacheImageNetworkWithShimmerLoading({
    required String imageUrl,
    required String title,
    required String dateTitle,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? margin,
  }) {
    return CachedNetworkImage(
      cacheManager: DefaultCacheManager(),
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, progress) => shimmerLoading(
        height: MediaQuery.of(context).size.height * 0.3,
        margin: margin,
        borderRadius: BorderRadius.circular(15),
      ),
      imageBuilder: (context, imageProvider) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              image: imageProvider,
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                border: Border.all(color: AppColors.transparent),
                gradient: LinearGradient(
                  colors: [
                    AppColors.blackk,
                    AppColors.whitee.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      title,
                      style: CommonText.style500S18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CommonText.normalIconText(
                      mainAxisAlignment: MainAxisAlignment.start,
                      icon: TablerIcons.calendar,
                      title: dateTitle,
                      color: AppColors.whitee,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              image: NetworkImage(url),
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                border: Border.all(color: AppColors.transparent),
                gradient: LinearGradient(
                  colors: [
                    AppColors.blackk,
                    AppColors.whitee.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      title,
                      style: CommonText.style500S18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CommonText.normalIconText(
                      mainAxisAlignment: MainAxisAlignment.start,
                      icon: TablerIcons.calendar,
                      title: dateTitle,
                      color: AppColors.whitee,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future showFlushBar({
    required String text,
    Color? color,
  }) {
    return Flushbar(
      messageText: Text(
        text,
        style: CommonText.style500S15,
      ),
      backgroundColor: color ?? AppColors.yelloww,
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: BorderRadius.circular(15),
      duration: Duration(seconds: 3),
    ).show(Get.context!);
  }

  static simpleConformationDialog({required Function() onPress}) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: AppColors.whitee,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            actionsPadding: EdgeInsets.all(15),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.logOutColan,
                  style: CommonText.style500S20.copyWith(
                    color: AppColors.blackk,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                AppString.areYouSureWantToLogout,
                textAlign: TextAlign.center,
                style: CommonText.style500S16.copyWith(
                  color: AppColors.blackk,
                ),
              ),
            ),
            insetPadding: EdgeInsets.all(20.sp),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.sp, vertical: 25.sp),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomOutLineButton(
                      txt: AppString.cancel,
                      onpressed: () {
                        Get.back();
                      },
                      isEnable: true,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    CustomElevatedButton(
                      onpressed: onPress,
                      txt: AppString.logOut,
                      isEnable: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static  appUpdateDialogBox({
    required String oldVersion,
    required String newVersion,
    required String title,
    required String subTitle,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actionsPadding: EdgeInsets.all(16),
              titlePadding: EdgeInsets.only(top: 20),
              title: Column(
                children: [
                  Icon(
                    Icons.system_update,
                    size: 40,
                    color: AppColors.yelloww,
                  ),
                  SizedBox(height: 12),
                  Text(
                    title,
                    style: CommonText.style600S18.copyWith(
                      color: AppColors.blackk,
                      fontSize: 20
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(thickness: 1, color: AppColors.greyy),
                    SizedBox(height: 10),
                    CommonText.richText(
                      firstTitle: AppString.oldVersion,
                      secTitle: oldVersion,
                      style: CommonText.style500S16.copyWith(
                        color: AppColors.greyyDark,
                      ),
                      style2: CommonText.style500S16.copyWith(
                        color: AppColors.redd,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    CommonText.richText(
                      firstTitle: AppString.newVersion,
                      secTitle: newVersion,
                      style: CommonText.style500S16.copyWith(
                        color: AppColors.greyyDark,
                      ),
                      style2: CommonText.style500S16.copyWith(
                        color: AppColors.greenn,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      AppString.whatsNew,
                      style: CommonText.style600S16.copyWith(
                        color: AppColors.blackk,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      subTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      onpressed: () async {
                        final url =
                            "https://drive.google.com/drive/folders/1i77jB0gRcBxuqTbQya1gLgjsSRiy5Kd4?usp=sharing";
                        Uri uri = Uri.parse(url);
                        if (!await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      txt: AppString.update,
                      isEnable: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static networkConformationDialog() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: AppColors.whitee,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            actionsPadding: EdgeInsets.all(15),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.networkIssueColan,
                  style: CommonText.style500S20.copyWith(
                    color: AppColors.blackk,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                AppString.noNetworkAvailable,
                textAlign: TextAlign.center,
                style: CommonText.style500S16.copyWith(
                  color: AppColors.blackk,
                ),
              ),
            ),
            insetPadding: EdgeInsets.all(20.sp),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.sp, vertical: 25.sp),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      onpressed: () {
                        Get.back();
                      },
                      txt: AppString.ok,
                      isEnable: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static deleteFireBaseData({required Function() onPress}) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: AppColors.whitee,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            actionsPadding: EdgeInsets.all(15),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.deleteColan,
                  style: CommonText.style500S20.copyWith(
                    color: AppColors.blackk,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                AppString.areYouSureWantToDeleteAllData,
                textAlign: TextAlign.center,
                style: CommonText.style500S16.copyWith(
                  color: AppColors.blackk,
                ),
              ),
            ),
            insetPadding: EdgeInsets.all(20.sp),
            contentPadding: EdgeInsets.all(10.sp),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomOutLineButton(
                      txt: AppString.cancel,
                      onpressed: () {
                        Get.back();
                      },
                      isEnable: true,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    CustomElevatedButton(
                      onpressed: onPress,
                      txt: AppString.delete,
                      isEnable: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static deleteConformationDialog({
    required Function() onConfirm,
    String? date,
    String? title,
    String? subTitle,
    String? confirmBtnName,
    String? cancelBtnName,
    Color? color,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: AppColors.whitee,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            actionsPadding: EdgeInsets.all(15),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? AppString.deleteColan,
                  style: CommonText.style500S20.copyWith(
                    color: AppColors.blackk,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CommonText.richText(
                maxLines: 3,
                textAlign: TextAlign.center,
                firstTitle: subTitle ??
                    AppString.areYouSureYouWantToDeleteYourWorkLogsFor,
                secTitle: date ?? '',
                fontSize: 18,
                color: AppColors.blackk,
                firstColor: AppColors.greyyDark,
              ),
            ),
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      onpressed: onConfirm,
                      txt: confirmBtnName ?? AppString.confirm,
                      clr: color ?? AppColors.redd,
                      isEnable: true,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    CustomOutLineButton(
                      txt: cancelBtnName ?? AppString.cancel,
                      onpressed: () {
                        Get.back();
                      },
                      isEnable: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static transparentDialog({
    required String date,
    Function()? onTap,
  }) {
    var context = Get.context!;
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (_) {
        return GetBuilder<TaskDashboardController>(builder: (tasDashCtrl) {
          PageController pageController = PageController();
          ValueNotifier<int> currentPage = ValueNotifier<int>(0);
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Dialog(
                  insetPadding:
                      EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: tasDashCtrl.isLoadingDateWise
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Center(
                              child: circleProcessIndicator(),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    // Date
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.yelloww
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        Global.formatDate(date),
                                        style: CommonText.style500S16.copyWith(
                                          color: AppColors.yelloww,
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      width: 20,
                                      color: AppColors.yelloww,
                                    ),

                                    Text(
                                      "${double.parse(tasDashCtrl.myWorkLogDateWiseModel?.labels?.totalHours ?? '0')} ${AppString.hours}",
                                      style: CommonText.style500S16.copyWith(
                                        color: AppColors.greyyDark,
                                      ),
                                    ),
                                    Spacer(),
                                    tasDashCtrl.myWorkLogDateWiseModel?.data
                                                ?.isNotEmpty ==
                                            true
                                        ? IconButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                AppColors.yelloww,
                                              ),
                                              shadowColor:
                                                  WidgetStatePropertyAll(
                                                      AppColors.blackk),
                                              elevation:
                                                  WidgetStatePropertyAll(2),
                                            ),
                                            onPressed: onTap,
                                            icon: Icon(
                                              TablerIcons.plus,
                                              color: AppColors.whitee,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: tasDashCtrl.myWorkLogDateWiseModel
                                                ?.data?.isEmpty ==
                                            true
                                        ? Column(
                                            children: [
                                              dataNotFound(),
                                              Spacer(),
                                              CustomTextIconButton(
                                                color: AppColors.yelloww,
                                                fontWeight: FontWeight.w600,
                                                txt: AppString.addWorkLog,
                                                onpressed: onTap,
                                                icon: TablerIcons.plus,
                                                isBgColor: true,
                                              ),
                                            ],
                                          )
                                        : PageView.builder(
                                            controller: pageController,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: tasDashCtrl
                                                .myWorkLogDateWiseModel
                                                ?.data
                                                ?.length,
                                            onPageChanged: (index) {
                                              currentPage.value = index;
                                            },
                                            itemBuilder: (context, index) {
                                              var tasK = tasDashCtrl
                                                  .myWorkLogDateWiseModel
                                                  ?.data?[index];
                                              var workDescription =
                                                  tasK?.workDescription ?? '';
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 5),
                                                padding: EdgeInsets.only(
                                                  left: 10,
                                                  top: 10,
                                                  right: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: AppColors.greyy,
                                                  ),
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              text: TextSpan(
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        '${tasK?.task?.projectCode} - ',
                                                                    style: CommonText
                                                                        .style500S15
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .blackk,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        '${tasK?.task?.projectName}',
                                                                    style: CommonText
                                                                        .style500S15
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .blues,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            surfaceTintColor:
                                                                AppColors
                                                                    .greenn,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                tasK?.logHours ??
                                                                    ' ',
                                                                style: CommonText
                                                                    .style500S15
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .greenn,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8.0),
                                                      RichText(
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: AppString
                                                                  .taskNameColan,
                                                              style: CommonText
                                                                  .style500S15
                                                                  .copyWith(
                                                                color: AppColors
                                                                    .blackk,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  '${tasK?.task?.taskName}',
                                                              style: CommonText
                                                                  .style500S15
                                                                  .copyWith(
                                                                color: AppColors
                                                                    .greenn,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.0),
                                                      HtmlWidget(
                                                        workDescription,
                                                        onTapUrl: (url) async {
                                                          Uri uri =
                                                              Uri.parse(url);
                                                          if (!await launchUrl(
                                                            uri,
                                                            mode: LaunchMode
                                                                .externalApplication,
                                                          )) {
                                                            throw Exception(
                                                                'Could not launch $url');
                                                          }
                                                          return true;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                  ValueListenableBuilder<int>(
                                    valueListenable: currentPage,
                                    builder: (context, value, child) {
                                      return SizedBox(
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              tasDashCtrl.myWorkLogDateWiseModel
                                                      ?.data?.length ??
                                                  0, (index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2),
                                              width: 8,
                                              height: 8,
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
                              ),
                            ],
                          ),
                  ),
                ),
                IconButton(
                  style: ButtonStyle(
                    // backgroundColor: WidgetStatePropertyAll(AppColors.greyy),
                    side: WidgetStatePropertyAll(
                      BorderSide(color: AppColors.whitee),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    TablerIcons.x,
                    color: AppColors.whitee,
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        });
      },
    );
  }

  static suggestReason({
    required BuildContext context,
    required Map<String, List<String>> reasonsByType,
    required TextEditingController textController,
    Function(String)? onDone,
  }) {
    PageController pageController = PageController();
    ValueNotifier<int> currentPage = ValueNotifier<int>(0);
    ValueNotifier<String?> selectedType = ValueNotifier<String?>(null);
    ValueNotifier<String?> selectedReason = ValueNotifier<String?>(null);

    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Center(
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            AppString.reasons,
                            style: CommonText.style600S18.copyWith(
                              color: AppColors.blackk,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 450.h,
                      child: ValueListenableBuilder<String?>(
                        valueListenable: selectedType,
                        builder: (_, selected, __) {
                          return PageView.builder(
                            controller: pageController,
                            physics: selected != null
                                ? null
                                : NeverScrollableScrollPhysics(),
                            onPageChanged: (index) => currentPage.value = index,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        AppString.selectType,
                                        style: CommonText.style600S15.copyWith(
                                          color: AppColors.greyyDark,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: reasonsByType.keys.map((type) {
                                        return ValueListenableBuilder<String?>(
                                          valueListenable: selectedType,
                                          builder: (_, selected, __) {
                                            return RadioListTile<String>(
                                              activeColor: AppColors.yelloww,
                                              value: type,
                                              groupValue: selected,
                                              onChanged: (value) {
                                                selectedType.value = value;
                                                if (value != null) {
                                                  pageController.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 600),
                                                    curve: Curves.easeInOut,
                                                  );
                                                }
                                              },
                                              title: Text(
                                                type,
                                                style: CommonText.style500S15
                                                    .copyWith(
                                                  color: AppColors.blackk,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        AppString.selectReason,
                                        style: CommonText.style600S15.copyWith(
                                          color: AppColors.greyyDark,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ValueListenableBuilder<String?>(
                                      valueListenable: selectedType,
                                      builder: (_, type, __) {
                                        if (type == null) {
                                          return Center(
                                            child: Text(
                                              AppString
                                                  .pleaseSelectATypeOnThePreviousPage,
                                              style: CommonText.style500S15
                                                  .copyWith(
                                                color: AppColors.blackk,
                                              ),
                                            ),
                                          );
                                        }
                                        List<String> reasons =
                                            reasonsByType[type]!;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: reasons.map((reason) {
                                            return ValueListenableBuilder<
                                                String?>(
                                              valueListenable: selectedReason,
                                              builder: (_, selected, __) {
                                                return RadioListTile<String>(
                                                  value: reason,
                                                  activeColor:
                                                      AppColors.yelloww,
                                                  groupValue: selected,
                                                  onChanged: (value) {
                                                    selectedReason.value =
                                                        value;
                                                  },
                                                  title: Text(
                                                    reason,
                                                    style: CommonText
                                                        .style500S15
                                                        .copyWith(
                                                      color: AppColors.blackk,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder<String?>(
                          valueListenable: selectedReason,
                          builder: (_, selected, __) {
                            return Visibility(
                              visible: selected != null,
                              child: CustomElevatedButton(
                                isEnable: selectedReason.value != null &&
                                    selectedReason.value!.isNotEmpty,
                                onpressed: () {
                                  textController.text = selectedReason.value!;
                                  onDone?.call(selectedReason.value!);
                                  Get.back();
                                }, // Disable action when no value is selected
                                txt: AppString.done,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static changePasswordDialog() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: AlertDialog(
                  insetPadding: EdgeInsets.all(15),
                  contentPadding: EdgeInsets.all(15),
                  actionsPadding: EdgeInsets.all(15),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  backgroundColor: AppColors.whitee,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  icon: AppBar(
                    surfaceTintColor: AppColors.whitee,
                    backgroundColor: AppColors.whitee,
                    shadowColor: AppColors.greyy,
                    elevation: 2,
                    automaticallyImplyLeading: false,
                    leading: Icon(Icons.lock_outline),
                    titleSpacing: 0,
                    title: Text(
                      AppString.changePassword,
                      style: CommonText.style600S16
                          .copyWith(color: AppColors.blackk),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),
                  iconPadding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFieldCustom(
                            autofillHints: [AutofillHints.password],
                            onChanged: (p0) {
                              controller.areAllRequiredFieldsFilled();
                              controller.update();
                            },
                            onPressed: () {
                              controller.isOldShow = !controller.isOldShow;
                              controller.update();
                            },
                            title: AppString.currentPassword,
                            hintText: AppString.enterCurrentPassword,
                            controller: controller.oldPasswordCtrl,
                            showSuffixIcon: true,
                            isShow: controller.isOldShow,
                            validator: (passCurrentValue) {
                              var regex = AppString.regExp;
                              var passNonNullValue = passCurrentValue ?? "";
                              if (passNonNullValue.isEmpty) {
                                return (AppString.plsEnterOldPassword);
                              } else if (passNonNullValue.length < 8) {
                                return (AppString.errorMinimum8char);
                              } else if (!regex.hasMatch(passNonNullValue)) {
                                return (AppString.errorAtLeastULNS);
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFieldCustom(
                            onChanged: (p0) {
                              controller.areAllRequiredFieldsFilled();
                              controller.update();
                            },
                            onPressed: () {
                              controller.isNewShow = !controller.isNewShow;
                              controller.update();
                            },
                            title: AppString.newPassword,
                            hintText: AppString.enterNewPassword,
                            controller: controller.newPasswordCtrl,
                            showSuffixIcon: true,
                            isShow: controller.isNewShow,
                            validator: (passCurrentValue) {
                              var regex = AppString.regExp;
                              var passNonNullValue = passCurrentValue ?? "";
                              if (passNonNullValue.isEmpty) {
                                return (AppString.plsEnterNewPassword);
                              } else if (passNonNullValue.length < 8) {
                                return (AppString.errorMinimum8char);
                              } else if (!regex.hasMatch(passNonNullValue)) {
                                return (AppString.errorAtLeastULNS);
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFieldCustom(
                            onChanged: (p0) {
                              controller.areAllRequiredFieldsFilled();
                              controller.update();
                            },
                            onPressed: () {
                              controller.isCnfNewShow =
                                  !controller.isCnfNewShow;
                              controller.update();
                            },
                            title: AppString.confirmNewPassword,
                            hintText: AppString.enterNewConfirmPassword,
                            controller: controller.cnfNewPasswordCtrl,
                            showSuffixIcon: true,
                            isShow: controller.isCnfNewShow,
                            validator: (passCurrentValue) {
                              var regex = AppString.regExp;
                              var passNonNullValue = passCurrentValue ?? "";
                              if (passNonNullValue.isEmpty) {
                                return (AppString.plsEnterCnfNewPassword);
                              } else if (passNonNullValue.length < 8) {
                                return (AppString.errorMinimum8char);
                              } else if (!regex.hasMatch(passNonNullValue)) {
                                return (AppString.errorAtLeastULNS);
                              } else if (controller.newPasswordCtrl.text !=
                                  passNonNullValue) {
                                return (AppString.errorPasswordNotMatch);
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          isLoading: controller.isChangePass,
                          isEnable: controller.areAllRequiredFieldsFilled(),
                          txt: AppString.submit,
                          onpressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.changePassword();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Future<void> switchAccount(List<StoredUser> users) async {
    String initials(String name) {
      List<String> parts = name.trim().split(" ");
      if (parts.length == 1) return parts[0][0];
      return parts[0][0] + parts[1][0];
    }

    var mainHomeController = Get.find<MainHomeController>();
    await Get.bottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: AppColors.blackk,
      SizedBox(
        height: MediaQuery.of(Get.context!).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20.h,
              margin: EdgeInsets.only(top: 5.h),
              child: Icon(
                Icons.maximize_rounded,
                size: 50.sp,
                color: AppColors.greyy,
              ),
            ),
            Container(
              height: 20.h,
              margin: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 5.h),
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.switchAccount,
                style: CommonText.style500S18,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 15.w, bottom: 10.h),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 5.h),
                  itemCount: users.length + 1,
                  itemBuilder: (context, index) {
                    if (index == users.length) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextButton(
                            txt: AppString.addAnotherAccount,
                            onpressed: () {
                              Get.back();
                              Get.toNamed(Routes.login, arguments: {
                                "isFromAddAccount": true,
                              });
                            },
                            color: AppColors.blues,
                          ),
                        ],
                      );
                    }

                    final user = users[index];

                    return InkWell(
                      onTap: () async {
                        if (!user.isCurrent) {
                          final updatedUsers = users.map((u) {
                            return u.copyWith(isCurrent: u.email == user.email);
                          }).toList();

                          const storage = FlutterSecureStorage();
                          await storage.write(
                            key: 'stored_users',
                            value: jsonEncode(
                                updatedUsers.map((e) => e.toJson()).toList()),
                          );

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          accessToken = user.accessToken;
                          refreshToken = user.refreshToken;
                          prefs.setString('accessToken', accessToken);
                          prefs.setString('refreshToken', refreshToken);
                          mainHomeController.onClose();
                          Get.offAllNamed(Routes.mainHome);
                          Get.back();
                        }
                      },
                      onLongPress: () {
                        deleteConformationDialog(
                          title: AppString.removeID,
                          subTitle: AppString.areYouSureYouWantToRemoveThisID,
                          color: AppColors.yelloww,
                          confirmBtnName: AppString.remove,
                          onConfirm: () async {
                            const storage = FlutterSecureStorage();

                            List<StoredUser> updatedUsers = users
                                .where((u) => u.email != user.email)
                                .toList();

                            if (user.isCurrent && updatedUsers.isNotEmpty) {
                              updatedUsers[0] =
                                  updatedUsers[0].copyWith(isCurrent: true);

                              accessToken = updatedUsers[0].accessToken;
                              refreshToken = updatedUsers[0].refreshToken;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('accessToken', accessToken);
                              prefs.setString('refreshToken', refreshToken);
                            }

                            await storage.write(
                              key: 'stored_users',
                              value: jsonEncode(
                                  updatedUsers.map((e) => e.toJson()).toList()),
                            );

                            if (updatedUsers.isEmpty) {
                              Get.offAllNamed(Routes.login);
                            } else {
                              Get.back();
                              Get.offAllNamed(Routes.mainHome);
                            }
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 12.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40.w,
                              height: 40.w,
                              child: CachedNetworkImage(
                                cacheManager: DefaultCacheManager(),
                                imageUrl: user.image.isNotEmpty
                                    ? user.image
                                    : 'https://your-default-placeholder.png',
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) =>
                                    Utility.circleProcessIndicator(),
                                errorWidget: (context, url, error) => Container(
                                  width: 50.w,
                                  height: 50.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitee,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    initials(user.name),
                                    style: CommonText.style700S13.copyWith(
                                      fontSize: 20.sp,
                                      color: AppColors.yelloww,
                                    ),
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: CommonText.style500S15.copyWith(
                                      color: AppColors.whitee,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    user.email,
                                    style: CommonText.style500S13.copyWith(
                                      color: AppColors.greyy,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Transform.scale(
                              scale: 1.7,
                              child: CupertinoRadio<bool>(
                                value: true,
                                groupValue: user.isCurrent,
                                onChanged: (_) async {
                                  if (!user.isCurrent) {
                                    final updatedUsers = users.map((u) {
                                      return u.copyWith(
                                          isCurrent: u.email == user.email);
                                    }).toList();

                                    const storage = FlutterSecureStorage();
                                    await storage.write(
                                      key: 'stored_users',
                                      value: jsonEncode(updatedUsers
                                          .map((e) => e.toJson())
                                          .toList()),
                                    );

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    accessToken = user.accessToken;
                                    refreshToken = user.refreshToken;
                                    prefs.setString('accessToken', accessToken);
                                    prefs.setString(
                                        'refreshToken', refreshToken);
                                    mainHomeController.onClose();
                                    Get.offAllNamed(Routes.mainHome);
                                    Get.back();
                                  }
                                },
                                fillColor: AppColors.whitee,
                                activeColor: AppColors.yelloww,
                                inactiveColor: AppColors.transparent,
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
          ],
        ),
      ),
    );
  }

  static venueBookedSlotDetails({
    required String title,
    required String titleName,
    required String playerOrEmployee,
    required String startTime,
    required String endTime,
    required String duration,
    required String hostOrCreatedBy,
    required String hostOrCreatedByName,
    required String teamsName,
    required String podsName,
    required var employeesName,
    required int maxLines,
    required int maxLinesForTeams,
    required int maxLinesForPods,
    required bool showOriginal,
    required bool showTeams,
    required bool showPods,
  }) async {
    return Get.bottomSheet(
      backgroundColor: AppColors.transparent,
      Container(
        margin: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          color: AppColors.blackk,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  AppString.details,
                  style: TextStyle(
                    color: AppColors.whitee,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close_outlined,
                    color: AppColors.whitee,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText.richText(
                    firstTitle: title,
                    secTitle: titleName,
                    color: AppColors.whitee,
                    fontSize: 15,
                    firstColor: AppColors.yelloww,
                    // maxLines: ,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerOrEmployee,
                    style: CommonText.style500S16.copyWith(
                      color: AppColors.yelloww,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 100.h, // Set maximum height
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        employeesName.isNotEmpty
                            ? employeesName
                            : AppString.wholeTeamOrPodsAreAvailable,
                        style: CommonText.style400S13,
                        maxLines: maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.startTime,
                        style: CommonText.style500S16.copyWith(
                          color: AppColors.yelloww,
                        ),
                      ),
                      Text(
                        "${Global.formatTime(
                          time: startTime,
                          showSeconds: true,
                          showAMPM: false,
                          showOriginal: showOriginal,
                        )} 🕛",
                        style: CommonText.style400S13,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.endTime,
                        style: CommonText.style500S16.copyWith(
                          color: AppColors.yelloww,
                        ),
                      ),
                      Text(
                        "${Global.formatTime(
                          time: endTime,
                          showSeconds: true,
                          showAMPM: false,
                          showOriginal: showOriginal,
                        )} 🕛",
                        style: CommonText.style400S13,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.duration,
                        style: CommonText.style500S16.copyWith(
                          color: AppColors.yelloww,
                        ),
                      ),
                      Text(
                        "$duration ⌛",
                        style: CommonText.style400S13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hostOrCreatedBy,
                    style: CommonText.style500S16.copyWith(
                      color: AppColors.yelloww,
                    ),
                  ),
                  Text(
                    hostOrCreatedByName,
                    style: CommonText.style400S13,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showTeams,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.teams,
                      style: CommonText.style500S16.copyWith(
                        color: AppColors.yelloww,
                      ),
                    ),
                    Text(
                      teamsName,
                      style: CommonText.style400S13,
                      maxLines: maxLinesForTeams,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: showPods,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.pods,
                      style: CommonText.style500S16.copyWith(
                        color: AppColors.yelloww,
                      ),
                    ),
                    Text(
                      podsName,
                      style: CommonText.style400S13,
                      maxLines: maxLinesForPods,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
