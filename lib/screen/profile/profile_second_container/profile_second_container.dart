// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/common_upper_container.dart';
import 'package:inexture/common_widget/global_value.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/app_string.dart';
import '../../../controller/time_format_controller.dart';

class ProfileSecondContainer extends StatelessWidget {
  ProfileSecondContainer({
    super.key,
    this.personOnTap,
    this.changePassOnTap,
    this.helpSupport,
    this.logoutOnTap,
    this.addAccount,
    this.settingOnTap,
    this.goToSomeWhere,
    this.visible = false,
  });

  Function()? personOnTap;
  Function()? changePassOnTap;
  Function()? helpSupport;
  Function()? logoutOnTap;
  Function()? addAccount;
  Function()? settingOnTap;
  Function()? goToSomeWhere;
  bool visible;

  @override
  Widget build(BuildContext context) {
    var wallPaperCtrl = Get.find<WallpaperController>();
    var timeFormatCtrl = Get.put(TimeFormatController());
    return PageView(
      physics: visible == true
          ? PageScrollPhysics()
          : NeverScrollableScrollPhysics(),
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                surfaceTintColor: AppColors.whitee,
                color: AppColors.whitee,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        splashColor: AppColors.transparent,
                        onTap: personOnTap,
                        leading: Icon(
                          Icons.person,
                          color: AppColors.blackk,
                        ),
                        title: Text(
                          AppString.personalInformation,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          color: AppColors.blackk,
                        ),
                      ),
                      ListTile(
                        splashColor: AppColors.transparent,
                        onTap: changePassOnTap,
                        leading: Icon(
                          Icons.lock_outlined,
                          color: AppColors.blackk,
                        ),
                        title: Text(
                          AppString.changePassword,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          color: AppColors.blackk,
                        ),
                      ),
                      /*ListTile(
                        splashColor: AppColors.transparent,
                        onTap: helpSupport,
                        leading: Icon(
                          TablerIcons.robot_face,
                          color: AppColors.blackk,
                        ),
                        title: Text(
                          'Chat With AI',
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                      ),*/
                      ListTile(
                        splashColor: AppColors.transparent,
                        leading: Icon(
                          TablerIcons.clock_12,
                          color: AppColors.blackk,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppString.use12HourFormat,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: CommonText.style500S15.copyWith(
                                color: AppColors.blackk,
                              ),
                            ),
                            Obx(
                              () => Text(
                                timeFormatCtrl.showOriginal.value
                                    ? AppString.d100pm
                                    : AppString.d1300am,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: CommonText.style500S12.copyWith(
                                  color: AppColors.greyyDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 50.w,
                          child: Obx(
                            () => FlutterSwitch(
                              value: timeFormatCtrl.showOriginal.value,
                              width: 50.w,
                              height: 25.h,
                              toggleSize: 20.0.sp,
                              showOnOff: true,
                              valueFontSize: 10,
                              onToggle: (value) async {
                                timeFormatCtrl.toggleShowOriginal(value: value);
                              },
                              activeColor: AppColors.yelloww,
                              inactiveColor: AppColors.greyy.withOpacity(0.4),
                              activeTextColor: AppColors.whitee,
                              inactiveTextColor: AppColors.blackk,
                              activeTextFontWeight: FontWeight.w400,
                              inactiveTextFontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        splashColor: AppColors.transparent,
                        leading: Icon(
                          Icons.wallpaper,
                          color: AppColors.blackk,
                        ),
                        title: Text(
                          AppString.setDefaultWallpaper,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blackk,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 50.w,
                          child: Obx(
                            () => FlutterSwitch(
                              value: !wallPaperCtrl.isRemoveWallPaper.value,
                              width: 50.w,
                              height: 25.h,
                              toggleSize: 20.0.sp,
                              showOnOff: true,
                              valueFontSize: 10,
                              onToggle: (value) async {
                                wallPaperCtrl.isRemoveWallPaper.value = !value;
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('isRemoveWallPaper',
                                    wallPaperCtrl.isRemoveWallPaper.value);
                              },
                              activeColor: AppColors.yelloww,
                              inactiveColor: AppColors.greyy.withOpacity(0.4),
                              activeTextColor: AppColors.whitee,
                              inactiveTextColor: AppColors.blackk,
                              activeTextFontWeight: FontWeight.w400,
                              inactiveTextFontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h,),
              Card(
                surfaceTintColor: AppColors.whitee,
                color: AppColors.whitee,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Visibility(
                      visible: users.contains(fireUserFullName),
                      child: ListTile(
                        minTileHeight: 40.h,
                        onTap: addAccount,
                        title: Text(
                          AppString.addAccount,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: CommonText.style500S15.copyWith(
                            color: AppColors.blues,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 40.h,
                      onTap: logoutOnTap,
                      leading: Icon(
                        Icons.logout_outlined,
                        color: AppColors.redd,
                      ),
                      title: Text(
                        AppString.logOut,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: CommonText.style500S15.copyWith(
                          color: AppColors.redd,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        Visibility(
          visible: visible,
          child: Center(
            child: TextButton(
              onPressed: goToSomeWhere,
              child: Text(
                "Go To SomeWhere",
                style: CommonText.style500S15.copyWith(
                  color: AppColors.greyy,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
