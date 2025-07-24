import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/common_flutter_switch.dart';
import 'package:inexture/model/all_active_user_model.dart';
import 'package:inexture/model/meeting_area_list_model.dart' as meeting;
import 'package:inexture/model/pods_model.dart';
import 'package:inexture/utils/utility.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/app_string.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/global_value.dart';
import '../../../common_widget/multi_select_dropdown_item_field.dart';
import '../../../common_widget/text.dart';
import '../../../common_widget/textfield.dart';
import '../../../controller/meeting_slot_booking_controller.dart';
import '../../../model/teams_model.dart';
import '../../../common_widget/button_ui.dart';

class MeetingSlotBooking extends GetView<MeetingSlotBookingController> {
  MeetingSlotBooking({super.key});

  @override
  final MeetingSlotBookingController controller =
      Get.put(MeetingSlotBookingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MeetingSlotBookingController>(builder: (mSBController) {
      return Scaffold(
        appBar: CommonAppBar.commonAppBar(
          context: context,
          title: AppString.meeting,
        ),
        body: mSBController.isLoading
            ? Utility.circleProcessIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
                  child: Form(
                    key: mSBController.meetingFormKey,
                    child: Column(
                      children: [
                        TextFieldCustom(
                          controller: mSBController.dateController,
                          isShow: true,
                          readOnly: true,
                          title: AppString.date,
                          hintText: AppString.selectDate,
                          validatorText: AppString.pleaseSelectDate,
                          fillColor: AppColors.transparent,
                          onTap: () async {
                            Set<DateTime> holidayDates = {};
                            DateTime? pickedDate =
                                await Global.showCustomDatePicker(
                              context,
                              false,
                              holidayDates,
                            );
                            if (pickedDate != null) {
                              mSBController.selectedDate =
                                  pickedDate.toString().split(' ')[0];
                              mSBController.dateController.text =
                                  Global.formatDate(
                                      pickedDate.toString().split(' ')[0]);
                              mSBController.updateButtonState();
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldCustom(
                                controller: mSBController.startTimeController,
                                fillColor:
                                    mSBController.dateController.text.isEmpty
                                        ? AppColors.greyy.withOpacity(0.2)
                                        : AppColors.transparent,
                                hintText: AppString.selectStartTime,
                                title: AppString.startTime,
                                enabled: mSBController
                                    .dateController.text.isNotEmpty,
                                readOnly: true,
                                isShow: true,
                                onTap: () async {
                                  TimeOfDay? initialTime;
                                  if (mSBController
                                      .startTimeController.text.isNotEmpty) {
                                    final timeParts = mSBController
                                        .startTimeController.text
                                        .split(':');
                                    initialTime = TimeOfDay(
                                      hour: int.parse(timeParts[0]),
                                      minute: int.parse(timeParts[1]),
                                    );
                                  } else {
                                    initialTime = TimeOfDay.now();
                                  }
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: initialTime,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColors.yelloww,
                                            onPrimary: AppColors.whitee,
                                            secondary: AppColors.yelloww,
                                            onSurface: AppColors.blackk,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.yelloww,
                                              textStyle: CommonText.style500S15
                                                  .copyWith(
                                                      color: AppColors.blackk),
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    final formattedTime =
                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                    mSBController.startTimeController.text =
                                        formattedTime;
                                    mSBController.startTime =
                                        Uri.encodeComponent(mSBController
                                            .startTimeController.text);
                                    log("Time Picked: ${mSBController.startTimeController.text} start Time : ${mSBController.startTime}");
                                    mSBController.update();
                                    if (mSBController
                                        .endTimeController.text.isNotEmpty) {
                                      mSBController.update();
                                      mSBController.calculateDuration();
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFieldCustom(
                                controller: mSBController.endTimeController,
                                fillColor: mSBController
                                        .startTimeController.text.isEmpty
                                    ? AppColors.greyy.withOpacity(0.2)
                                    : AppColors.transparent,
                                hintText: AppString.selectEndTime,
                                title: AppString.endTime,
                                enabled: mSBController
                                    .startTimeController.text.isNotEmpty,
                                readOnly: true,
                                isShow: true,
                                onTap: () async {
                                  TimeOfDay? initialTime;
                                  if (mSBController
                                      .endTimeController.text.isNotEmpty) {
                                    final timeParts = mSBController
                                        .endTimeController.text
                                        .split(':');
                                    initialTime = TimeOfDay(
                                      hour: int.parse(timeParts[0]),
                                      minute: int.parse(timeParts[1]),
                                    );
                                  } else {
                                    initialTime = TimeOfDay.now();
                                  }
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: initialTime,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: AppColors.yelloww,
                                            onPrimary: AppColors.whitee,
                                            secondary: AppColors.yelloww,
                                            onSurface: AppColors.blackk,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.yelloww,
                                              textStyle: CommonText.style500S15
                                                  .copyWith(
                                                      color: AppColors.blackk),
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    final formattedTime =
                                        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                    mSBController.endTimeController.text =
                                        formattedTime;
                                    mSBController.endTime = Uri.encodeComponent(
                                        mSBController.endTimeController.text);
                                    log("Time Picked: ${mSBController.endTimeController.text} end Time : ${mSBController.endTime}");
                                    mSBController.calculateDuration();
                                    mSBController.getMeetingArea();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        TextFieldCustom(
                          controller: mSBController.totalDurationController,
                          fillColor: AppColors.transparent,
                          hintText: mSBController.totalDuration,
                          title: AppString.durationHours,
                          readOnly: true,
                          isShow: true,
                        ),
                        CustomMultiSelectDropDown(
                          isDropDownDisable: mSBController.isShowMeetingArea,
                          isForMeetingArea: true,
                          isLoading: mSBController.isLoading,
                          hintText: AppString.selectEmployees,
                          isVisible:
                              mSBController.selectedMeetingArea?.isEmpty ==
                                  true,
                          title: AppString.availableVenue,
                          items: mSBController.meetingAreaListData
                                  ?.map((item) => item.name.toString())
                                  .toList() ??
                              [],
                          selectedItems: mSBController.selectedMeetingArea
                                  ?.map((item) => item.name.toString())
                                  .toList() ??
                              [],
                          validator: (value) {
                            return null;
                          },
                          dropdownBuilder: (context, selectedItemNames) {
                            return Wrap(
                              spacing: 5.0,
                              direction: Axis.horizontal,
                              children: selectedItemNames.map((itemName) {
                                final item = mSBController.selectedMeetingArea
                                    ?.firstWhere(
                                  (items) => items.name == itemName,
                                );
                                return InputChip(
                                  deleteIcon: Icon(
                                    CupertinoIcons.clear_circled_solid,
                                  ),
                                  onDeleted: () {
                                    mSBController.updateButtonState();
                                    mSBController.selectedMeetingArea
                                        ?.remove(item);
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
                            mSBController.selectedMeetingArea?.clear();
                            mSBController.selectedMeetingArea?.addAll(
                              selectedNames.map(
                                (name) => meeting.Data(
                                  id: mSBController.meetingAreaListData
                                      ?.firstWhere(
                                        (item) => item.name == name,
                                        orElse: () => meeting.Data(
                                          id: 0,
                                          name: '',
                                        ),
                                      )
                                      .id,
                                  name: name,
                                ),
                              ),
                            );
                            mSBController.updateButtonState();
                          },
                        ),
                        Visibility(
                          visible: !mSBController.isSelectAll,
                          child: CustomMultiSelectDropDown(
                            isLoading: mSBController.isLoading,
                            isOptional: true,
                            isVisible: mSBController.selectedTeam.isEmpty,
                            hintText: AppString.selectTeam,
                            title: AppString.team,
                            items: mSBController.teamsModal
                                .map((item) => item.name.toString())
                                .toList(),
                            selectedItems: mSBController.selectedTeam
                                .map((item) => item.name.toString())
                                .toList(),
                            validator: (p0) {},
                            dropdownBuilder: (context, selectedItemNames) {
                              return Wrap(
                                spacing: 5.0,
                                direction: Axis.horizontal,
                                children: selectedItemNames.map((itemName) {
                                  final item =
                                      mSBController.selectedTeam.firstWhere(
                                    (items) => items.name == itemName,
                                  );
                                  return InputChip(
                                    deleteIcon: Icon(
                                      CupertinoIcons.clear_circled_solid,
                                    ),
                                    onDeleted: () {
                                      mSBController.selectedTeam.remove(item);
                                      mSBController.updateButtonState();
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
                              mSBController.selectedTeam.clear();
                              mSBController.selectedTeam.addAll(
                                selectedNames.map(
                                  (name) => TeamsModal(
                                    name: name,
                                    id: mSBController.teamsModal
                                        .firstWhere(
                                          (item) => item.name == name,
                                          orElse: () => TeamsModal(
                                            name: '',
                                            id: 0,
                                          ),
                                        )
                                        .id,
                                  ),
                                ),
                              );
                              mSBController.updateButtonState();
                            },
                          ),
                        ),
                        Visibility(
                          visible: !mSBController.isSelectAll,
                          child: CustomMultiSelectDropDown(
                            isLoading: mSBController.isLoading,
                            isOptional: true,
                            isVisible: mSBController.selectedPods.isEmpty,
                            hintText: AppString.selectPods,
                            title: AppString.pods,
                            items: mSBController.podsModel
                                .map((item) => item.name.toString())
                                .toList(),
                            selectedItems: mSBController.selectedPods
                                .map((item) => item.name.toString())
                                .toList(),
                            validator: (p0) {},
                            dropdownBuilder: (context, selectedItemNames) {
                              return Wrap(
                                spacing: 5.0,
                                direction: Axis.horizontal,
                                children: selectedItemNames.map((itemName) {
                                  final item =
                                      mSBController.selectedPods.firstWhere(
                                    (items) => items.name == itemName,
                                  );
                                  return InputChip(
                                    deleteIcon: Icon(
                                      CupertinoIcons.clear_circled_solid,
                                    ),
                                    onDeleted: () {
                                      mSBController.selectedPods.remove(item);
                                      mSBController.updateButtonState();
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
                              mSBController.selectedPods.clear();
                              mSBController.selectedPods.addAll(
                                selectedNames.map(
                                  (name) => PodsModel(
                                    name: name,
                                    id: mSBController.podsModel
                                        .firstWhere(
                                          (item) => item.name == name,
                                          orElse: () => PodsModel(
                                            name: '',
                                            id: 0,
                                          ),
                                        )
                                        .id,
                                  ),
                                ),
                              );
                              mSBController.updateButtonState();
                            },
                          ),
                        ),
                        Stack(
                          children: [
                            CustomMultiSelectDropDown(
                              isLoading: mSBController.isLoading,
                              isVisible:
                                  mSBController.selectedEmployee?.isEmpty ==
                                      true,
                              hintText: AppString.selectEmployees,
                              title: AppString.employees,
                              items: mSBController.data
                                      ?.map((item) =>
                                          "${item.firstName} ${item.lastName}")
                                      .toList() ??
                                  [],
                              selectedItems: mSBController.selectedEmployee
                                      ?.map((item) =>
                                          "${item.firstName} ${item.lastName}")
                                      .toList() ??
                                  [],
                              validator: (value) {
                                if (value!.length < 2 || value.isEmpty) {
                                  return "At least two employees are required";
                                }
                                return null;
                              },
                              dropdownBuilder: (context, selectedItemNames) {
                                return Wrap(
                                  spacing: 5.0,
                                  direction: Axis.horizontal,
                                  children: selectedItemNames.map((itemName) {
                                    final item = mSBController.selectedEmployee
                                        ?.firstWhere(
                                      (items) =>
                                          "${items.firstName} ${items.lastName}" ==
                                          itemName,
                                    );
                                    return InputChip(
                                      deleteIcon: Icon(
                                        CupertinoIcons.clear_circled_solid,
                                      ),
                                      onDeleted: () {
                                        mSBController.selectedEmployee
                                            ?.remove(item);
                                        mSBController.isSelectAll = false;
                                        mSBController.updateButtonState();
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
                                mSBController.selectedEmployee?.clear();
                                mSBController.selectedEmployee?.addAll(
                                  selectedNames.map(
                                    (name) {
                                      final fullNameParts = name.split(' ');
                                      final firstName = fullNameParts[0];
                                      final lastName = fullNameParts.length > 1
                                          ? fullNameParts[1]
                                          : '';

                                      final matchedEmployee =
                                          mSBController.data?.firstWhere(
                                        (item) =>
                                            "${item.firstName} ${item.lastName}" ==
                                            name,
                                        orElse: () => Data(
                                            id: 0, firstName: '', lastName: ''),
                                      );
                                      return Data(
                                        id: matchedEmployee?.id ?? 0,
                                        firstName: firstName,
                                        lastName: lastName,
                                      );
                                    },
                                  ),
                                );
                                mSBController.updateButtonState();
                              },
                            ),
                            Positioned(
                              top: 12.h,
                              right: 0,
                              child: CommonFlutterSwitch(
                                value: mSBController.isSelectAll,
                                onToggle: (isSelectedAll) {
                                  mSBController.isSelectAll = isSelectedAll;
                                  if (isSelectedAll) {
                                    mSBController.selectedEmployee ??= [];
                                    final newSelections = mSBController.data
                                        ?.where((employee) => !mSBController
                                            .selectedEmployee!
                                            .any((selected) =>
                                                selected.id == employee.id))
                                        .toList();
                                    mSBController.selectedEmployee
                                        ?.addAll(newSelections ?? []);
                                  } else {
                                    mSBController.selectedEmployee?.clear();
                                    mSBController.selectedTeam.clear();
                                    mSBController.selectedPods.clear();
                                  }
                                  mSBController.updateButtonState();
                                  mSBController.update();
                                },
                                title: AppString.selectAll,
                                activeText: '',
                                inactiveText: '',
                                height: 22.h,
                                width: 45.w,
                                padding: 2.sp,
                                toggleSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: TextFieldCustom(
                            controller: mSBController.descriptionController,
                            hintText: AppString.enterDescription,
                            title: AppString.description,
                            fillColor: AppColors.transparent,
                            isShow: true,
                            maxLines: 5,
                            onChanged: (p0) {
                              mSBController.updateButtonState();
                            },
                            isBottomScrollPadding: true,
                          ),
                        ),
                        ButtonUi(
                          yes: AppString.create,
                          isEnable: mSBController.isCreatingButtonEnabled,
                          isLoading: mSBController.isCreating,
                          onPressedSubmit: () {
                            if (mSBController.meetingFormKey.currentState!
                                .validate()) {
                              mSBController.createMeeting();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
