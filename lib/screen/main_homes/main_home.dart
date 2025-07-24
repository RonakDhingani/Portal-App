// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/screen/home/home.dart';
import 'package:inexture/screen/profile/profile.dart';
import 'package:inexture/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_menu/star_menu.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../common_widget/asset.dart';
import '../../common_widget/global_value.dart';
import '../../controller/main_home_controller.dart';
import '../../routes/app_pages.dart';
import '../services.dart';
import '../task.dart';
import 'bottom_Icon_container.dart';

class MainHomeScreen extends GetView<MainHomeController> {
  MainHomeScreen({super.key});

  @override
  final MainHomeController controller = Get.put(MainHomeController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (controller.currentIndex == 0) {
            SystemNavigator.pop();
          } else {
            controller.currentIndex = 0;
            controller.update();
          }
        }
      },
      child: GetBuilder<MainHomeController>(
        builder: (mainHomeController) {
          return Scaffold(
            body: IndexedStack(
              index: mainHomeController.currentIndex,
              children: [
                HomeScreen(),
                Task(),
                ServicesScreen(),
                Profile(),
              ],
            ),
            extendBody: true,
            floatingActionButton: /*mainHomeController.currentIndex == 1
                    ? null
                    :*/
                BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: mainHomeController.isMenuOpen ? 3 : 0,
                sigmaY: mainHomeController.isMenuOpen ? 3 : 0,
              ),
              child: StarMenu(
                controller: mainHomeController.centerStarMenuController,
                items: mainHomeController.otherEntries,
                onStateChanged: (state) {
                  if (state.name == AppString.closed) {
                    mainHomeController.isMenuOpen = false;
                    mainHomeController.update();
                  } else {
                    mainHomeController.isMenuOpen = true;
                    mainHomeController.update();
                  }
                },
                onItemTapped: (index, controller) =>
                    mainHomeController.centerStarMenuController.closeMenu!(),
                parentContext: mainHomeController.containerKey.currentContext,
                child: FloatingActionButton(
                  heroTag: 'unique_FAB',
                  onPressed: null,
                  shape: CircleBorder(),
                  backgroundColor: AppColors.yelloww,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final rotationAnimation =
                          Tween<double>(begin: 0.75, end: 1.0)
                              .animate(animation);
                      return RotationTransition(
                        turns: rotationAnimation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Icon(
                      mainHomeController.isMenuOpen ? Icons.close : Icons.add,
                      color: AppColors.blackk,
                      key: ValueKey(mainHomeController.isMenuOpen
                          ? AppString.close
                          : AppString.add),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: /*mainHomeController.currentIndex == 1
                    ? null
                    : */
                StylishBottomBar(
              hasNotch: true,
              notchStyle: NotchStyle.circle,
              fabLocation: StylishBarFabLocation.center,
              onTap: (value) {
                mainHomeController.currentIndex = value;
                mainHomeController.update();
              },
              backgroundColor: AppColors.whitee,
              currentIndex: mainHomeController.currentIndex,
              option: AnimatedBarOptions(),
              items: [
                BottomBarItem(
                  unSelectedColor: mainHomeController.unSelectedItem,
                  selectedColor: mainHomeController.selectedItem,
                  icon: IconContainer(
                    isOnlyIconContainer: true,
                    img: AssetImg.homeImg,
                  ),
                  selectedIcon: IconContainer(
                    isOnlyIconContainer: false,
                    img: AssetImg.homeFillImg,
                  ),
                  title: Text(
                    AppString.home,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CommonText.style500S14.copyWith(
                      color: AppColors.blackk,
                    ),
                  ),
                ),
                BottomBarItem(
                  unSelectedColor: mainHomeController.unSelectedItem,
                  selectedColor: mainHomeController.selectedItem,
                  icon: IconContainer(
                    isOnlyIconContainer: true,
                    img: AssetImg.tasksImg,
                  ),
                  selectedIcon: IconContainer(
                    isOnlyIconContainer: false,
                    img: AssetImg.tasksFillImg,
                  ),
                  title: Text(
                    AppString.tasks,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CommonText.style500S14.copyWith(
                      color: AppColors.blackk,
                    ),
                  ),
                ),
                BottomBarItem(
                  unSelectedColor: mainHomeController.unSelectedItem,
                  selectedColor: mainHomeController.selectedItem,
                  icon: IconContainer(
                    isOnlyIconContainer: true,
                    img: AssetImg.servicesImg,
                  ),
                  selectedIcon: IconContainer(
                    isOnlyIconContainer: false,
                    img: AssetImg.servicesFillImg,
                  ),
                  title: Text(
                    AppString.services,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CommonText.style500S14.copyWith(
                      color: AppColors.blackk,
                    ),
                  ),
                ),
                BottomBarItem(
                  unSelectedColor: mainHomeController.unSelectedItem,
                  selectedColor: mainHomeController.selectedItem,
                  icon: IconContainer(
                    onDoubleTap: () async {
                      final users = await mainHomeController.getStoredUsers();
                      if (users.length < 2) return;

                      int currentIndex = users.indexWhere((u) => u.isCurrent);
                      int nextIndex = (currentIndex + 1) % users.length;

                      final updatedUsers = users.map((u) {
                        return u.copyWith(
                            isCurrent: u.email == users[nextIndex].email);
                      }).toList();

                      const storage = FlutterSecureStorage();
                      await storage.write(
                        key: 'stored_users',
                        value: jsonEncode(
                            updatedUsers.map((e) => e.toJson()).toList()),
                      );

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      accessToken = users[nextIndex].accessToken;
                      refreshToken = users[nextIndex].refreshToken;
                      prefs.setString('accessToken', accessToken);
                      prefs.setString('refreshToken', refreshToken);

                      mainHomeController.onClose();
                      Get.offAllNamed(Routes.mainHome);
                    },
                    onLongPress: () async {
                      Utility.switchAccount(
                          await mainHomeController.getStoredUsers());
                    },
                    isOnlyIconContainer: true,
                    img: AssetImg.profileImg,
                  ),
                  selectedIcon: IconContainer(
                    onLongPress: () async {
                      Utility.switchAccount(
                          await mainHomeController.getStoredUsers());
                    },
                    onDoubleTap: () async {
                      final users = await mainHomeController.getStoredUsers();
                      if (users.length < 2) return;

                      int currentIndex = users.indexWhere((u) => u.isCurrent);
                      int nextIndex = (currentIndex + 1) % users.length;

                      final updatedUsers = users.map((u) {
                        return u.copyWith(
                            isCurrent: u.email == users[nextIndex].email);
                      }).toList();

                      const storage = FlutterSecureStorage();
                      await storage.write(
                        key: 'stored_users',
                        value: jsonEncode(
                            updatedUsers.map((e) => e.toJson()).toList()),
                      );

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      accessToken = users[nextIndex].accessToken;
                      refreshToken = users[nextIndex].refreshToken;
                      prefs.setString('accessToken', accessToken);
                      prefs.setString('refreshToken', refreshToken);

                      mainHomeController.onClose();
                      Get.offAllNamed(Routes.mainHome);
                    },
                    isOnlyIconContainer: false,
                    img: AssetImg.profileFillImg,
                  ),
                  title: Text(
                    AppString.profile,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: CommonText.style500S14.copyWith(
                      color: AppColors.blackk,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
