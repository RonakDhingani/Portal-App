// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/multi_select_dropdown_item_field.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/common_widget/textfield.dart';
import 'package:inexture/screen/leave/my_leave/add_leave_component/adhoc_drop_down.dart';
import 'package:inexture/common_widget/button_ui.dart';
import 'package:inexture/screen/leave/my_leave/add_leave_component/day_type_ui.dart';
import 'package:inexture/screen/leave/my_leave/add_leave_component/phone_field_ui.dart';
import 'package:inexture/utils/utility.dart';

import '../../../common_widget/common_flutter_switch.dart';
import '../../../common_widget/global_value.dart';
import '../../../controller/add_leave_controller.dart';
import '../../../controller/main_home_controller.dart';

class AddLeave extends GetView<AddLeaveController> {
  AddLeave({super.key});

  @override
  AddLeaveController controller = Get.put(AddLeaveController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLeaveController>(
      builder: (addLeaveController) {
        var userDetails =
            Get.find<MainHomeController>().userProfileDetailsModel?.data;

        return GestureDetector(
          onTap: () {
            Utility.hideKeyboard(context);
          },
          child: Scaffold(
            appBar: CommonAppBar.commonAppBar(
              context: context,
              title: AppString.addLeave,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: addLeaveController.formKey,
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
                  child: Column(
                    children: [
                      DayTypeUi(
                        groupValueDayType: addLeaveController.selectedDayType,
                        groupValueHalfTime: addLeaveController.selectedHalfTime,
                        onChangedDayType: (value) {
                          if (value != AppString.half) {
                            addLeaveController.selectedHalfTime = '';
                          }
                          addLeaveController
                              .updateSelectedDayType(value ?? '0');
                          if (value != AppString.half) {
                            if (addLeaveController
                                    .startDateController.text.isNotEmpty &&
                                addLeaveController
                                    .endDateController.text.isNotEmpty) {
                              addLeaveController.getDateDurationCalculation(
                                startDate: addLeaveController.startDate,
                                endDate: addLeaveController.endDate,
                              );
                            }
                          }
                        },
                        onChangedHalfTime: (valueTime) {
                          addLeaveController
                              .updateSelectedHalfTime(valueTime ?? '0');
                          if (addLeaveController
                                  .startDateController.text.isNotEmpty &&
                              addLeaveController
                                  .endDateController.text.isNotEmpty) {
                            addLeaveController.getDateDurationCalculation(
                              startDate: addLeaveController.startDate,
                              endDate: addLeaveController.endDate,
                            );
                          }
                        },
                        visible: addLeaveController.selectedDayType == AppString.half,
                      ),
                      TextFieldCustom(
                        controller: addLeaveController.requestController,
                        readOnly: true,
                        title: AppString.requestFrom,
                        fillColor: AppColors.transparent,
                        hintText:
                            '${userDetails?.firstName} ${userDetails?.lastName}',
                      ),
                      CustomMultiSelectDropDown(
                        isLoading: addLeaveController.isLoading,
                        title: AppString.sendRequestTo,
                        items: addLeaveController.sendRequestItems
                            .map((item) => item.name)
                            .toList(),
                        selectedItems: addLeaveController.selectedItems
                            .map((item) => item.name)
                            .toList(),
                        dropdownBuilder: (context, selectedItemNames) {
                          return Wrap(
                                  spacing: 5.0,
                                  direction: Axis.horizontal,
                                  children: selectedItemNames.map((itemName) {
                                    final item = addLeaveController
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
                                        addLeaveController
                                            .allActiveUserModel?.data
                                            ?.forEach(
                                          (allUser) {
                                            if (addLeaveController
                                                .alreadyAvailableItems
                                                .contains(itemName)) {
                                            } else {
                                              addLeaveController.selectedItems
                                                  .remove(item);
                                              addLeaveController.update();
                                            }
                                          },
                                        );
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
                          addLeaveController.selectedItems.clear();
                          addLeaveController.selectedItems.addAll(
                            selectedNames.map(
                              (name) => Item(
                                name: name,
                                id: addLeaveController.sendRequestItems
                                    .firstWhere(
                                      (item) => item.name == name,
                                      orElse: () => Item(name: '', id: 0),
                                    )
                                    .id,
                              ),
                            ),
                          );
                          addLeaveController.update();
                        },
                      ),
                      AdhocAddOnDropDown(
                        controller: addLeaveController.adhocController,
                        value: addLeaveController.isAdhoc,
                        title: AppString.isAdhoc,
                        hintText: AppString.selectAdhocStatus,
                        statusTitle: AppString.adhocStatus,
                        visible: addLeaveController.isAdhoc,
                        onToggle: (value) {
                          addLeaveController.isAdhoc = value;
                          addLeaveController.update();
                          addLeaveController.updateSubmitButtonState();
                        },
                        onSelected: (value) {
                          addLeaveController.updateSubmitButtonState();
                        },
                        dropdownMenuEntries:
                            addLeaveController.adhocListItem.map((data) {
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
                      AdhocAddOnDropDown(
                        controller: addLeaveController.addOnLeaveController,
                        value: addLeaveController.isAddOnLeave,
                        title: AppString.isAddOn,
                        hintText: AppString.selectAddOnLeave,
                        statusTitle: AppString.addOnLeave,
                        visible: addLeaveController.isAddOnLeave,
                        onToggle: (value) {
                          addLeaveController.isAddOnLeave = value;
                          addLeaveController.update();
                          addLeaveController.updateSubmitButtonState();
                        },
                        onSelected: (value) {
                          addLeaveController.addOnLeaveID = value;
                          addLeaveController.updateSubmitButtonState();
                        },
                        dropdownMenuEntries: addLeaveController
                                .variableLeaveSettingsModel?.data
                                ?.map((data) {
                              return DropdownMenuEntry<String>(
                                value: '${data.id}',
                                label: '${data.leaveType}',
                                style: ButtonStyle(
                                  textStyle: WidgetStatePropertyAll(
                                    CommonText.style500S15.copyWith(
                                      color: AppColors.blackk,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(growable: true) ??
                            [],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldCustom(
                              controller:
                                  addLeaveController.startDateController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.startDate,
                              hintText: AppString.selectStartDate,
                              validatorText: AppString.pleaseSelectStartDate,
                              fillColor: AppColors.transparent,
                              onTap: () async {
                                Set<DateTime> holidayDates = {};
                                holidayDates = addLeaveController
                                    .holidayDateModels
                                    .map((holiday) =>
                                        DateTime.parse(holiday.date!))
                                    .toSet();
                                DateTime? pickedDate =
                                    await Global.showCustomDatePicker(
                                  context,
                                  addLeaveController.isAdhoc,
                                  holidayDates,
                                );
                                if (pickedDate != null) {
                                  addLeaveController.setStartDate(pickedDate);
                                }
                                addLeaveController.updateSubmitButtonState();
                              },
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              controller: addLeaveController.endDateController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.endDate,
                              hintText: AppString.selectEndDate,
                              validatorText: addLeaveController
                                      .startDateController.text.isNotEmpty
                                  ? AppString.pleaseSelectEndDate
                                  : '',
                              fillColor: addLeaveController
                                      .startDateController.text.isEmpty
                                  ? AppColors.greyy.withOpacity(0.1)
                                  : AppColors.transparent,
                              onTap: () async {
                                Set<DateTime> holidayDates = {};
                                holidayDates = addLeaveController
                                    .holidayDateModels
                                    .map((holiday) =>
                                        DateTime.parse(holiday.date!))
                                    .toSet();
                                if (addLeaveController
                                    .startDateController.text.isEmpty) {
                                  Utility.showFlushBar(
                                      text: AppString.pleaseSelectStartDate);
                                } else {
                                  DateTime? pickedDate =
                                      await Global.showCustomDatePicker(
                                    context,
                                    addLeaveController.isAdhoc,
                                    holidayDates,
                                  );
                                  if (pickedDate != null) {
                                    addLeaveController.setEndDate(pickedDate);
                                  }
                                }
                                addLeaveController.updateSubmitButtonState();
                              },
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              controller: addLeaveController.totalDayController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.totalLeaves,
                              hintText: AppString.totalLeaves,
                              fillColor: AppColors.greyy.withOpacity(0.1),
                              showPrefixIcon:
                                  addLeaveController.isDateDurationLoading,
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              controller:
                                  addLeaveController.returnDateController,
                              isShow: true,
                              readOnly: true,
                              title: AppString.returnDate,
                              hintText: AppString.returnDate,
                              fillColor: AppColors.greyy.withOpacity(0.1),
                              showPrefixIcon:
                                  addLeaveController.isDateDurationLoading,
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
                          controller: addLeaveController.reasonController,
                          hintText: AppString.enterReason,
                          validatorText: AppString.pleaseEnterYourReason,
                          title: AppString.reason,
                          fillColor: AppColors.transparent,
                          isShow: true,
                          maxLines: 5,
                          isBottomScrollPadding: true,
                          isNeedHelp: true,
                          onChanged: (value) {
                            addLeaveController.updateSubmitButtonState();
                          },
                          onTapNeedHelp: () {
                            Utility.suggestReason(
                              context: context,
                              textController:
                                  addLeaveController.reasonController,
                              reasonsByType: addLeaveController.reasonsByType,
                              onDone: (p0) {
                                addLeaveController.reasonController.text = p0;
                                addLeaveController.updateSubmitButtonState();
                                addLeaveController.update();
                              },
                            );
                          },
                        ),
                      ),
                      PhoneFieldUi(
                        controller: addLeaveController.phoneController,
                        onChanged: (phone) {
                          addLeaveController.countryCode = phone.countryCode;
                          addLeaveController.update();
                        },
                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return 'Please Enter a Phone Number';
                          } else if (!RegExp(
                                  r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                              .hasMatch(phone.number)) {
                            return "Please Enter a Valid Phone Number";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: CommonFlutterSwitch(
                          value: addLeaveController.isAvailabilityOnPhone,
                          onToggle: (value) {
                            addLeaveController.isAvailabilityOnPhone = value;
                            addLeaveController.update();
                          },
                          title: AppString.availabilityOnPhone,
                        ),
                      ),
                      CommonFlutterSwitch(
                        value: addLeaveController.isAvailabilityInCity,
                        onToggle: (value) {
                          addLeaveController.isAvailabilityInCity = value;
                          addLeaveController.update();
                        },
                        title: AppString.availabilityInCity,
                      ),
                      ButtonUi(
                        isEnable: addLeaveController.isSubmitButtonEnabled,
                        isLoading: addLeaveController.isSubmitting,
                        onPressedSubmit: () {
                          if (addLeaveController.formKey.currentState!
                              .validate()) {
                            if (addLeaveController.isAdhoc == true ||
                                addLeaveController.isAddOnLeave == true) {
                              if (addLeaveController
                                      .adhocController.text.isNotEmpty ||
                                  addLeaveController
                                      .addOnLeaveController.text.isNotEmpty) {
                                addLeaveController.submitData();
                              } else {
                                Utility.showFlushBar(
                                    text:
                                        "please select ${addLeaveController.isAdhoc ? AppString.adhocStatus : AppString.addOnLeave}");
                              }
                            } else {
                              addLeaveController.submitData();
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
