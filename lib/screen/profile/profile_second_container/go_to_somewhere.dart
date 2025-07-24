import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/textfield.dart';
import '../../../controller/go_to_somewhere_controller.dart';

class GoToSomewhere extends GetView<GoToSomewhereController> {
  GoToSomewhere({super.key});

  @override
  final GoToSomewhereController controller = Get.put(GoToSomewhereController());

  TextSpan highlightMatch(String source, String query) {
    final matchIndex = source.toLowerCase().indexOf(query.toLowerCase());
    if (matchIndex == -1 || query.isEmpty) {
      return TextSpan(
        text: source,
        style: CommonText.style600S16.copyWith(color: AppColors.blackk),
      );
    }

    return TextSpan(
      children: [
        TextSpan(text: source.substring(0, matchIndex)),
        TextSpan(
          text: source.substring(matchIndex, matchIndex + query.length),
          style: CommonText.style600S16.copyWith(color: AppColors.blues),
        ),
        TextSpan(text: source.substring(matchIndex + query.length)),
      ],
      style: CommonText.style600S16.copyWith(color: AppColors.blackk),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoToSomewhereController>(
      builder: (goToSomewhereCtrl) {
        return GestureDetector(
          onTap: () {
            Utility.hideKeyboard(context);
          },
          child: Scaffold(
            appBar: CommonAppBar.commonAppBar(
              context: context,
              title: AppString.userPassword,
              widget: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        goToSomewhereCtrl.users.length.toString(),
                        style: CommonText.style600S18,
                      ),
                      Icon(
                        Icons.people_alt_rounded,
                        color: AppColors.whitee,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      Utility.deleteFireBaseData(
                        onPress: () {
                          Get.back();
                          goToSomewhereCtrl.isLoading = true;
                          goToSomewhereCtrl.update();
                          goToSomewhereCtrl.userService.deleteAllUsers().then(
                            (value) {
                              goToSomewhereCtrl.fetchAllUsers();
                              return value;
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
            ),
            body: goToSomewhereCtrl.isLoading
                ? Utility.circleProcessIndicator()
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 10, left: 15, right: 10),
                        child: TextFieldCustom(
                          controller: goToSomewhereCtrl.searchField,
                          inputAction: TextInputAction.search,
                          fillColor: AppColors.transparent,
                          onFieldSubmitted: (value) {
                            goToSomewhereCtrl.onSearch(value);
                          },
                          onChanged: (value) {
                            goToSomewhereCtrl.onSearch(value);
                          },
                          isTitleHide: true,
                          isShow: true,
                          labelText: AppString.search,
                          showSuffixIcon:
                              goToSomewhereCtrl.searchField.text.isNotEmpty
                                  ? true
                                  : false,
                          suffixIcon: IconButton(
                            icon: Icon(
                              TablerIcons.x,
                              color: AppColors.blackk,
                            ),
                            onPressed: () {
                              goToSomewhereCtrl.searchField.clear();
                              goToSomewhereCtrl.onSearch('');
                            },
                          ),
                        ),
                      ),
                      goToSomewhereCtrl.users.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Utility.dataNotFound(),
                              ),
                            )
                          : Expanded(
                              child: goToSomewhereCtrl.groupedUsers.isEmpty
                                  ? Center(child: Utility.dataNotFound())
                                  : ListView(
                                      children: () {
                                        int globalIndex = 1; // start index at 1
                                        return goToSomewhereCtrl
                                            .groupedUsers.entries
                                            .map((entry) {
                                          final section = entry.key;
                                          final userList = entry.value;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 20.0, right: 20.0),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                decoration: BoxDecoration(
                                                    color: AppColors.blackk,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      section,
                                                      style: CommonText
                                                          .style600S18
                                                          .copyWith(
                                                        color:
                                                            AppColors.yelloww,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ...userList.map(
                                                (user) {
                                                  final index = globalIndex++;
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 8.0),
                                                    child: Card(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: AppColors
                                                                        .blackk),
                                                                SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        highlightMatch(
                                                                      user.fireUserName,
                                                                      controller
                                                                          .searchField
                                                                          .text,
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    final combined =
                                                                        '${user.fireUserID} || ${user.password}';
                                                                    Clipboard
                                                                        .setData(
                                                                      ClipboardData(
                                                                          text:
                                                                              combined),
                                                                    );
                                                                    Utility.showFlushBar(
                                                                        text:
                                                                            "User ID & Password copied to clipboard");
                                                                  },
                                                                  child: Icon(
                                                                    Icons.copy,
                                                                    color: AppColors
                                                                        .greyyDark,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .badge_outlined,
                                                                    color: AppColors
                                                                        .greyyDark),
                                                                SizedBox(
                                                                    width: 10),
                                                                CommonText
                                                                    .richText(
                                                                  firstTitle:
                                                                      "ID: ",
                                                                  secTitle: user
                                                                      .fireUserID,
                                                                  color: AppColors
                                                                      .greyyDark,
                                                                  maxLines: 2,
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Clipboard.setData(
                                                                        ClipboardData(
                                                                            text:
                                                                                user.fireUserID));
                                                                    Utility.showFlushBar(
                                                                        text:
                                                                            "User ID copied to clipboard");
                                                                  },
                                                                  child: Icon(
                                                                    Icons.copy,
                                                                    size: 20,
                                                                    color: AppColors
                                                                        .greyyDark,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .lock_outline,
                                                                    color: AppColors
                                                                        .yelloww),
                                                                SizedBox(
                                                                    width:
                                                                        10.w),
                                                                Flexible(
                                                                  child: CommonText
                                                                      .richText(
                                                                    firstTitle:
                                                                        "Password: ",
                                                                    secTitle: user
                                                                        .password,
                                                                    color: AppColors
                                                                        .greyyDark,
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Clipboard
                                                                        .setData(
                                                                      ClipboardData(
                                                                          text:
                                                                              user.password),
                                                                    );
                                                                    Utility.showFlushBar(
                                                                        text:
                                                                            "Password copied to clipboard");
                                                                  },
                                                                  child: Icon(
                                                                    Icons.copy,
                                                                    size: 20,
                                                                    color: AppColors
                                                                        .greyyDark,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        }).toList();
                                      }(),
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
