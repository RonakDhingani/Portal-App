// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/app_string.dart';
import '../../common_widget/common_app_bar.dart';
import '../../common_widget/global_value.dart';
import '../../common_widget/multi_select_dropdown_item_field.dart';
import '../../common_widget/text.dart';
import '../../common_widget/textfield.dart';
import '../../controller/add_leave_controller.dart';
import '../../controller/add_work_from_home_controller.dart';
import '../../controller/main_home_controller.dart';
import '../../utils/utility.dart';
import '../leave/my_leave/add_leave_component/adhoc_drop_down.dart';
import '../../common_widget/button_ui.dart';
import '../leave/my_leave/add_leave_component/day_type_ui.dart';

class AddWorkFromHome extends GetView<AddWorkFromHomeController> {
  AddWorkFromHome({super.key});

  @override
  AddWorkFromHomeController controller = Get.put(AddWorkFromHomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWorkFromHomeController>(
      builder: (addWorkFromHomeController) {
        var userDetails =
            Get.find<MainHomeController>().userProfileDetailsModel?.data;
        return GestureDetector(
          onTap: () {
            Utility.hideKeyboard(context);
          },
          child: Scaffold(
            appBar: CommonAppBar.commonAppBar(
              context: context,
              title: AppString.addWorkFromHome,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: addWorkFromHomeController.formKey,
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
                  child: Column(
                    children: [
                      DayTypeUi(
                        groupValueDayType:
                            addWorkFromHomeController.selectedDayType,
                        groupValueHalfTime:
                            addWorkFromHomeController.selectedHalfTime,
                        onChangedDayType: (value) {
                          if (value != 'half') {
                            addWorkFromHomeController.selectedHalfTime = '';
                          }
                          addWorkFromHomeController
                              .updateSelectedDayType(value ?? '0');
                          if (value != 'half') {
                            if (addWorkFromHomeController
                                    .startDateController.text.isNotEmpty &&
                                addWorkFromHomeController
                                    .endDateController.text.isNotEmpty) {
                              addWorkFromHomeController
                                  .getDateDurationCalculation(
                                startDate: addWorkFromHomeController.startDate,
                                endDate: addWorkFromHomeController.endDate,
                              );
                            }
                          }
                        },
                        onChangedHalfTime: (valueTime) {
                          addWorkFromHomeController
                              .updateSelectedHalfTime(valueTime ?? '0');
                          if (addWorkFromHomeController
                                  .startDateController.text.isNotEmpty &&
                              addWorkFromHomeController
                                  .endDateController.text.isNotEmpty) {
                            addWorkFromHomeController
                                .getDateDurationCalculation(
                              startDate: addWorkFromHomeController.startDate,
                              endDate: addWorkFromHomeController.endDate,
                            );
                          }
                        },
                        visible:
                            addWorkFromHomeController.selectedDayType == 'half',
                      ),
                      TextFieldCustom(
                        controller: addWorkFromHomeController.requestController,
                        readOnly: true,
                        title: AppString.requestFrom,
                        fillColor: AppColors.transparent,
                        hintText:
                            '${userDetails?.firstName} ${userDetails?.lastName}',
                      ),
                      CustomMultiSelectDropDown(
                        isLoading: addWorkFromHomeController.isLoading,
                        title: AppString.sendRequestTo,
                        items: addWorkFromHomeController.sendRequestItems
                            .map((item) => item.name)
                            .toList(),
                        selectedItems: addWorkFromHomeController.selectedItems
                            .map((item) => item.name)
                            .toList(),
                        dropdownBuilder: (context, selectedItemNames) {
                          return Wrap(
                            spacing: 5.0,
                            direction: Axis.horizontal,
                            children: selectedItemNames.map((itemName) {
                              final item = addWorkFromHomeController
                                  .selectedItems
                                  .firstWhere(
                                (item) => item.name == itemName,
                                orElse: () => Item(name: '', id: 0),
                              );
                              return InputChip(
                                deleteIcon: Icon(
                                  CupertinoIcons.clear_circled_solid,
                                ),
                                onDeleted: () {
                                  addWorkFromHomeController
                                      .allActiveUserModel?.data
                                      ?.forEach(
                                    (allUser) {
                                      if (addWorkFromHomeController
                                          .alreadyAvailableItems
                                          .contains(itemName)) {
                                      } else {
                                        addWorkFromHomeController.selectedItems
                                            .remove(item);
                                        addWorkFromHomeController.update();
                                      }
                                    },
                                  );
                                },
                                deleteIconColor: AppColors.greyyDark,
                                label: SizedBox(
                                  height: 20,
                                  child: Text(
                                    itemName,
                                    style: CommonText.style400S14.copyWith(
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
                          addWorkFromHomeController.selectedItems.clear();
                          addWorkFromHomeController.selectedItems.addAll(
                            selectedNames.map(
                              (name) => Item(
                                name: name,
                                id: addWorkFromHomeController.sendRequestItems
                                    .firstWhere(
                                      (item) => item.name == name,
                                      orElse: () => Item(name: '', id: 0),
                                    )
                                    .id,
                              ),
                            ),
                          );
                          addWorkFromHomeController.update();
                        },
                      ),
                      AdhocAddOnDropDown(
                        controller: addWorkFromHomeController.adhocController,
                        value: addWorkFromHomeController.isAdhoc,
                        title: AppString.isAdhoc,
                        hintText: AppString.selectAdhocStatus,
                        statusTitle: AppString.adhocStatus,
                        visible: addWorkFromHomeController.isAdhoc,
                        onToggle: (value) {
                          if (value == false) {
                            addWorkFromHomeController.adhocController.clear();
                            addWorkFromHomeController.update();
                          }
                          addWorkFromHomeController.isAdhoc = value;
                          addWorkFromHomeController.update();
                          addWorkFromHomeController.updateSubmitButtonState();
                        },
                        onSelected: (value) {
                          addWorkFromHomeController.updateSubmitButtonState();
                        },
                        dropdownMenuEntries:
                            addWorkFromHomeController.adhocListItem.map((data) {
                          return DropdownMenuEntry<String>(
                            value: data,
                            label: data,
                            style: ButtonStyle(
                              textStyle: WidgetStatePropertyAll(
                                CommonText.style500S15.copyWith(
                                  color: AppColors.blackk,
                                ),
                              ),
                            ),
                          );
                        }).toList(growable: true),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldCustom(
                              controller:
                                  addWorkFromHomeController.startDateController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.startDate,
                              hintText: AppString.selectStartDate,
                              validatorText: AppString.pleaseSelectStartDate,
                              fillColor: AppColors.transparent,
                              onTap: () async {
                                Set<DateTime> holidayDates = {};
                                holidayDates = addWorkFromHomeController
                                    .holidayDateModels
                                    .map((holiday) =>
                                        DateTime.parse(holiday.date!))
                                    .toSet();
                                DateTime? pickedDate =
                                    await Global.showCustomDatePicker(
                                  context,
                                  addWorkFromHomeController.isAdhoc,
                                  holidayDates,
                                );
                                if (pickedDate != null) {
                                  addWorkFromHomeController
                                      .setStartDate(pickedDate);
                                }
                                addWorkFromHomeController
                                    .updateSubmitButtonState();
                              },
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              controller:
                                  addWorkFromHomeController.endDateController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.endDate,
                              hintText: AppString.selectEndDate,
                              validatorText: addWorkFromHomeController
                                      .startDateController.text.isNotEmpty
                                  ? AppString.pleaseSelectEndDate
                                  : '',
                              fillColor: addWorkFromHomeController
                                      .startDateController.text.isEmpty
                                  ? AppColors.greyy.withOpacity(0.1)
                                  : AppColors.transparent,
                              onTap: () async {
                                Set<DateTime> holidayDates = {};
                                holidayDates = addWorkFromHomeController
                                    .holidayDateModels
                                    .map((holiday) =>
                                        DateTime.parse(holiday.date!))
                                    .toSet();
                                if (addWorkFromHomeController
                                    .startDateController.text.isEmpty) {
                                  Utility.showFlushBar(
                                      text: AppString.pleaseSelectStartDate);
                                } else {
                                  DateTime? pickedDate =
                                      await Global.showCustomDatePicker(
                                    context,
                                    addWorkFromHomeController.isAdhoc,
                                    holidayDates,
                                  );
                                  if (pickedDate != null) {
                                    addWorkFromHomeController
                                        .setEndDate(pickedDate);
                                  }
                                }
                                addWorkFromHomeController
                                    .updateSubmitButtonState();
                              },
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              controller:
                                  addWorkFromHomeController.totalDayController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.totalLeaves,
                              hintText: AppString.totalLeaves,
                              fillColor: AppColors.greyy.withOpacity(0.1),
                              showPrefixIcon: addWorkFromHomeController
                                  .isDateDurationLoading,
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              controller: addWorkFromHomeController
                                  .returnDateController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.returnDate,
                              hintText: AppString.returnDate,
                              fillColor: AppColors.greyy.withOpacity(0.1),
                              showPrefixIcon: addWorkFromHomeController
                                  .isDateDurationLoading,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: TextFieldCustom(
                          controller:
                              addWorkFromHomeController.reasonController,
                          hintText: AppString.enterReason,
                          validatorText: AppString.pleaseEnterYourReason,
                          title: AppString.reason,
                          fillColor: AppColors.transparent,
                          isShow: true,
                          maxLines: 5,
                          isBottomScrollPadding: true,
                          isNeedHelp: true,
                          onChanged: (value) {
                            addWorkFromHomeController.updateSubmitButtonState();
                          },
                          onTapNeedHelp: () {
                            Utility.suggestReason(
                              context: context,
                              textController:
                                  addWorkFromHomeController.reasonController,
                              reasonsByType:
                                  addWorkFromHomeController.reasonsByType,
                              onDone: (p0) {
                                addWorkFromHomeController
                                    .reasonController.text = p0;
                                addWorkFromHomeController.update();
                              },
                            );
                          },
                        ),
                      ),
                      ButtonUi(
                        isEnable:
                            addWorkFromHomeController.isSubmitButtonEnabled,
                        isLoading: addWorkFromHomeController.isSubmitting,
                        onPressedSubmit: () {
                          if (addWorkFromHomeController.formKey.currentState!
                              .validate()) {
                            if (addWorkFromHomeController.isAdhoc == true) {
                              if (addWorkFromHomeController
                                  .adhocController.text.isNotEmpty) {
                                addWorkFromHomeController
                                    .submitDataForWorkFromHome();
                              } else {
                                Utility.showFlushBar(
                                    text: AppString.pleaseSelectAdhocStatus);
                              }
                            } else {
                              addWorkFromHomeController
                                  .submitDataForWorkFromHome();
                            }
                          } else {
                            print('somewhere some field is empty or invalid');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
