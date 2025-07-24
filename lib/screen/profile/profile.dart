// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/routes/app_pages.dart';
import 'package:inexture/screen/profile/profile_second_container/profile_second_container.dart';
import 'package:inexture/screen/profile/profile_ui.dart';
import 'package:inexture/utils/utility.dart';

import '../../common_widget/common_upper_container.dart';
import '../../common_widget/global_value.dart';
import '../../controller/home_controller.dart';
import '../../controller/main_home_controller.dart';
import '../../controller/profile_controller.dart';

class Profile extends GetView<ProfileController> {
  Profile({super.key});

  @override
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileCtrl) {
        var userDetails =
            Get.find<MainHomeController>().userProfileDetailsModel?.data;
        var homeController = Get.find<HomeController>();
        return Scaffold(
          body: Stack(
            children: [
              UpperContainer(
                isProfile: true,
                isTodayBDay: homeController.todayBirthdayModel?.data
                        ?.any((details) => details.id == userId) ??
                    false,
                firstChild: ProfileUi(
                  imgUrl: '${userDetails?.image}',
                  firstName: userDetails?.firstName ?? '\t',
                  lastName: userDetails?.lastName ?? '\t',
                  designation:
                      userDetails?.userdetails?.designationName?.name ?? '\t',
                ),
                secondChild: ProfileSecondContainer(
                  personOnTap: () {
                    Get.toNamed(Routes.personalInformation);
                  },
                  changePassOnTap: () {
                    Utility.changePasswordDialog();
                  },
                  helpSupport: () {
                    Get.toNamed(Routes.chatWithAi);
                  },
                  logoutOnTap: () {
                    Utility.simpleConformationDialog(
                      onPress: () {
                        Get.back();
                        profileCtrl.logout();
                      },
                    );
                  },
                  goToSomeWhere: () {
                    Get.toNamed(Routes.goToSomewhere);
                  },
                  addAccount: () {
                    Get.toNamed(Routes.login, arguments: {"isFromAddAccount": true,});
                  },
                  visible: profileCtrl.showUserNamePass(),
                ),
              ),
              if (profileCtrl.isLoading) Utility.circleProcessIndicator(),
            ],
          ),
        );
      },
    );
  }
}
