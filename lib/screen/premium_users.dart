import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/text.dart';

import '../common_widget/app_string.dart';
import '../common_widget/common_app_bar.dart';
import '../common_widget/profile_image.dart';
import '../common_widget/textfield.dart';
import '../controller/premium_users_controller.dart';
import '../model/all_active_user_model.dart';
import '../utils/utility.dart';

class PremiumUsers extends GetView<PremiumUsersController> {
  const PremiumUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PremiumUsersController>(
      builder: (premiumUsersCtrl) {
        return GestureDetector(
          onTap: () {
            Utility.hideKeyboard(context);
          },
          child: Scaffold(
            appBar: CommonAppBar.commonAppBar(
              context: context,
              title: AppString.premiumUsers,
              widget: Visibility(
                visible: premiumUsersCtrl.isSelectionMode &&
                    premiumUsersCtrl.selectedUsers.isNotEmpty,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextButton(
                    onPressed: premiumUsersCtrl.cancelSelection,
                    child: Text(
                      AppString.clearAll,
                      style: CommonText.style600S15
                          .copyWith(color: AppColors.whitee),
                    ),
                  ),
                ),
              ),
            ),
            body: premiumUsersCtrl.isLoading
                ? Utility.circleProcessIndicator()
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 10, left: 15, right: 10),
                        child: TextFieldCustom(
                          controller: premiumUsersCtrl.searchField,
                          inputAction: TextInputAction.search,
                          fillColor: AppColors.transparent,
                          onChanged: (value) {
                            premiumUsersCtrl.filterUsers();
                            premiumUsersCtrl.update();
                          },
                          isTitleHide: true,
                          isShow: true,
                          labelText: AppString.search,
                          showSuffixIcon:
                              premiumUsersCtrl.searchField.text.isNotEmpty
                                  ? true
                                  : false,
                          suffixIcon: IconButton(
                            icon: Icon(
                              TablerIcons.x,
                              color: AppColors.blackk,
                            ),
                            onPressed: () {
                              premiumUsersCtrl.searchField.clear();
                              premiumUsersCtrl.filterUsers();
                              premiumUsersCtrl.update();
                            },
                          ),
                        ),
                      ),
                      premiumUsersCtrl.filteredUsers.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Utility.dataNotFound(),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: ListView.builder(
                                  itemCount:
                                      premiumUsersCtrl.filteredUsers.length,
                                  itemBuilder: (context, index) {
                                    var user =
                                        premiumUsersCtrl.filteredUsers[index];
                                    var fullName =
                                        "${user.firstName} ${user.lastName}";
                                    final query = premiumUsersCtrl
                                        .searchField.text
                                        .toLowerCase();
                                    bool isSelected = premiumUsersCtrl
                                        .selectedUsers
                                        .contains(user);
                                    bool isAlreadyPremium = premiumUsersCtrl
                                        .alreadyPremiumUsers
                                        .any((e) => e.name == fullName);
                                    bool isSelectedToRemove =
                                        isSelected && isAlreadyPremium;
                                    return Card(
                                      elevation: isAlreadyPremium ? 2.0 : 1.0,
                                      surfaceTintColor: isSelectedToRemove
                                          ? Colors.red.withOpacity(0.1)
                                          : isAlreadyPremium
                                              ? AppColors.greenn
                                              : isSelected
                                                  ? AppColors.blues
                                                  : null,
                                      child: ListTile(
                                        onTap: () {
                                          if (premiumUsersCtrl
                                              .isSelectionMode) {
                                            premiumUsersCtrl
                                                .toggleSelection(user);
                                            premiumUsersCtrl.update();
                                          }
                                        },
                                        onLongPress: () {
                                          premiumUsersCtrl.isSelectionMode =
                                              true;
                                          premiumUsersCtrl
                                              .toggleSelection(user);
                                          premiumUsersCtrl.update();
                                        },
                                        contentPadding: EdgeInsets.all(10),
                                        leading: Container(
                                          margin: EdgeInsets.all(5),
                                          child: ProfileImage(
                                            userName:
                                                '${user.firstName?[0].toUpperCase()}${user.lastName?[0].toUpperCase()}',
                                            profileImage: '',
                                            name: fullName,
                                            radius: 25,
                                            borderWidth: 1,
                                          ),
                                        ),
                                        title: _highlightMatch(fullName, query),
                                        subtitle: isAlreadyPremium
                                            ? Text(
                                                'Already Added',
                                                style: CommonText.style400S14
                                                    .copyWith(
                                                  color: isSelectedToRemove
                                                      ? AppColors.redd
                                                      : AppColors.greenn,
                                                ),
                                              )
                                            : null,
                                        trailing: isSelected || isAlreadyPremium
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: CircleAvatar(
                                                  radius: 20.r,
                                                  backgroundColor:
                                                      isSelectedToRemove
                                                          ? AppColors.redd
                                                          : isAlreadyPremium
                                                              ? AppColors.greenn
                                                              : AppColors.blues,
                                                  child: Icon(
                                                    isSelectedToRemove
                                                        ? Icons.remove
                                                        : Icons.done,
                                                    color: AppColors.whitee,
                                                    size: 16,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
            floatingActionButton: controller.isSelectionMode &&
                    controller.selectedUsers.isNotEmpty
                ? FloatingActionButton(
                    onPressed: () async {
                      final List<Data> toDelete =
                          controller.selectedUsers.where((user) {
                        final fullName = "${user.firstName} ${user.lastName}";
                        return controller.alreadyPremiumUsers
                            .any((e) => e.name == fullName);
                      }).toList();
                      final List<Data> toAdd =
                          controller.selectedUsers.where((user) {
                        final fullName = "${user.firstName} ${user.lastName}";
                        return !controller.alreadyPremiumUsers
                            .any((e) => e.name == fullName);
                      }).toList();
                      if (toDelete.isNotEmpty) {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Remove Selected Users"),
                            content: Text(
                                "Do you want to remove ${toDelete.length} selected user(s) from premium list?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text("Remove"),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await controller.removeUsersFromFirebase(toDelete);
                        }
                      }
                      if (toAdd.isNotEmpty) {
                        await controller.saveUsersToFirebase(toAdd);
                      }
                      controller.cancelSelection();
                      controller.update();
                    },
                    backgroundColor: AppColors.yelloww,
                    shape: CircleBorder(),
                    child: Icon(
                      color: AppColors.blackk,
                      controller.selectedUsers.any((user) =>
                              controller.alreadyPremiumUsers.any((e) =>
                                  e.name ==
                                  "${user.firstName} ${user.lastName}"))
                          ? Icons.delete
                          : TablerIcons.upload,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  RichText _highlightMatch(String fullName, String query) {
    if (query.isEmpty) {
      return RichText(
        text: TextSpan(
          text: fullName,
          style: CommonText.style500S15.copyWith(color: AppColors.blackk),
        ),
      );
    }

    final lowerName = fullName.toLowerCase();
    final matchStart = lowerName.indexOf(query);
    if (matchStart < 0) {
      return RichText(
        text: TextSpan(
          text: fullName,
          style: CommonText.style500S15.copyWith(color: AppColors.blackk),
        ),
      );
    }

    final matchEnd = matchStart + query.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: fullName.substring(0, matchStart),
            style: CommonText.style500S15.copyWith(color: AppColors.blackk),
          ),
          TextSpan(
            text: fullName.substring(matchStart, matchEnd),
            style: CommonText.style500S15.copyWith(
              color: AppColors.yelloww,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: fullName.substring(matchEnd),
            style: CommonText.style500S15.copyWith(color: AppColors.blackk),
          ),
        ],
      ),
    );
  }
}
