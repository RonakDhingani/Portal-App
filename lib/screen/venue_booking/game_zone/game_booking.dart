// ignore_for_file: prefer_const_literals_to_create_immutables


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/utils/utility.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/app_string.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/multi_select_dropdown_item_field.dart';
import '../../../common_widget/text.dart';
import '../../../common_widget/textfield.dart';
import '../../../controller/game_booking_controller.dart';
import '../../../model/game_zone_user_model.dart';
import '../../../common_widget/button_ui.dart';

class GameBooking extends GetView<GameBookingController> {
  GameBooking({super.key});

  @override
  final GameBookingController controller = Get.put(GameBookingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameBookingController>(
      builder: (gameBookingCtrl) {
        return Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: '${AppString.gameBooking} - ${gameBookingCtrl.gameName}',
          ),
          body: gameBookingCtrl.isLoading
              ? Utility.circleProcessIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 50),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldCustom(
                              controller: gameBookingCtrl.startTimeController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.startTime,
                              hintText: AppString.selectStartDate,
                              fillColor: AppColors.greyy.withOpacity(0.2),
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              controller: gameBookingCtrl.endTimeController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.endTime,
                              hintText: AppString.selectEndDate,
                              fillColor: AppColors.greyy.withOpacity(0.2),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                        CustomMultiSelectDropDown(
                          isLoading: gameBookingCtrl.isLoading,
                          title: AppString.employees,
                          hintText: AppString.selectEmployees,
                          items: gameBookingCtrl.gameZoneUserModel
                              .map((item) => item.label.toString())
                              .toList(),
                          selectedItems: gameBookingCtrl.selectUsers
                              .map((item) => item.label.toString())
                              .toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'At least two players are required';
                            }
                            return null;
                          },
                          dropdownBuilder: (context, selectedItemNames) {
                            return Wrap(
                                    spacing: 5.0,
                                    direction: Axis.horizontal,
                                    children: selectedItemNames.map((itemName) {
                                      final item = gameBookingCtrl.selectUsers
                                          .firstWhere(
                                        (items) => items.label == itemName,
                                        orElse: () => GameZoneUserModel(
                                            label: '', id: 0, value: ''),
                                      );
                                      return InputChip(
                                        deleteIcon: Icon(
                                          CupertinoIcons.clear_circled_solid,
                                        ),
                                        onDeleted: () {
                                          gameBookingCtrl.selectUsers
                                              .remove(item);
                                          gameBookingCtrl.updateButtonState();
                                        },
                                        deleteIconColor: AppColors.greyyDark,
                                        label: SizedBox(
                                          height: 20,
                                          child: Text(
                                            itemName,
                                            style:
                                                CommonText.style400S14.copyWith(
                                              color: AppColors.blackk,
                                            ),
                                          ),
                                        ),
                                        shape: StadiumBorder(),
                                      );
                                    }).toList(),
                                  );
                          },
                          onChanged: (selectedNames) {
                            gameBookingCtrl.selectUsers.clear();
                            gameBookingCtrl.selectUsers.addAll(
                              selectedNames.map(
                                (name) => GameZoneUserModel(
                                  label: name,
                                  id: gameBookingCtrl.gameZoneUserModel
                                      .firstWhere(
                                        (item) => item.label == name,
                                        orElse: () => GameZoneUserModel(
                                            label: '', id: 0, value: ''),
                                      )
                                      .id,
                                ),
                              ),
                            );
                            gameBookingCtrl.updateButtonState();
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: TextFieldCustom(
                            isOptional: true,
                            controller: gameBookingCtrl.descriptionController,
                            hintText: AppString.enterDescription,
                            title: AppString.description,
                            fillColor: AppColors.transparent,
                            isShow: true,
                            maxLines: 5,
                            isBottomScrollPadding: true,
                          ),
                        ),
                        ButtonUi(
                          yes: AppString.create,
                          isEnable: gameBookingCtrl.isSubmitButtonEnabled,
                          isLoading: gameBookingCtrl.isCreating,
                          onPressedSubmit: () {
                            gameBookingCtrl.bookingGameSlot();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
