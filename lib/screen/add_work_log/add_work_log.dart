// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/textfield.dart';
import 'package:inexture/screen/add_work_log/work_log_description_field.dart';
import 'package:inexture/common_widget/button_ui.dart';
import 'package:inexture/utils/utility.dart';

import '../../common_widget/app_string.dart';
import '../../common_widget/common_dropdown_menu.dart';
import '../../controller/add_work_log_controller.dart';
import '../../routes/app_pages.dart';

class AddWorkLog extends GetView<AddWorkLogController> {
  AddWorkLog({super.key});

  @override
  final AddWorkLogController controller = Get.put(AddWorkLogController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWorkLogController>(
        builder: (addWorkLogController) {
      return GestureDetector(
        onTap: () => Utility.hideKeyboard(context),
        child: Scaffold(
          appBar: CommonAppBar.commonAppBar(
            context: context,
            isButtonHide: false,
            title: addWorkLogController.isFromEdit
                ? AppString.editWorkLog
                : AppString.addWorkLog,
          ),
          body: SingleChildScrollView(
            controller: addWorkLogController.containerScrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: addWorkLogController.addWorkLogFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonDropdown(
                      title: AppString.selectProject,
                      hint: AppString.selectProject,
                      isEnabled: !addWorkLogController.isFromEdit,
                      items: addWorkLogController.getProjectNames(),
                      selectedValue: addWorkLogController.selectedProject.isEmpty
                          ? null
                          : addWorkLogController.selectedProject,
                      onChanged: (newValue) {
                        addWorkLogController.setSelectedProject(newValue ?? '');
                        addWorkLogController.updateSubmitButtonState();
                      },
                    ),
                    SizedBox(height: 16),
                    CommonDropdown(
                      title: AppString.selectTask,
                      hint: AppString.selectTask,
                      selectedValue: addWorkLogController.selectedTask.isEmpty
                          ? null
                          : addWorkLogController.selectedTask,
                      items: addWorkLogController
                          .getTaskNames(addWorkLogController.selectedProject),
                      onChanged: addWorkLogController.selectedProject.isEmpty
                          ? (_) {}
                          : (newValue) {
                              addWorkLogController
                                  .setSelectedTask(newValue ?? '');
                              addWorkLogController.updateSubmitButtonState();
                            },
                      isEnabled: addWorkLogController.isFromEdit == true
                          ? !addWorkLogController.isFromEdit
                          : addWorkLogController.selectedProject.isNotEmpty,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonDropdown(
                            title: AppString.logHours,
                            hint: AppString.selectHours,
                            selectedValue:
                                addWorkLogController.selectedHours.isEmpty
                                    ? null
                                    : addWorkLogController.selectedHours,
                            items: List.generate(17, (index) => index.toString()),
                            onChanged: (newValue) {
                              addWorkLogController.setSelectedHours(newValue!);
                              addWorkLogController.updateSubmitButtonState();
                            },

                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CommonDropdown(
                            title: AppString.logMinutes,
                            hint: AppString.selectMinutes,
                            selectedValue:
                                addWorkLogController.selectedMinutes.isEmpty
                                    ? null
                                    : addWorkLogController.selectedMinutes,
                            items: List.generate(60, (index) {
                              if (index < 10) {
                                return '0$index';
                              } else {
                                return index.toString();
                              }
                            }),
                            onChanged: (newValue) {
                              addWorkLogController.setSelectedMinutes(newValue!);
                              addWorkLogController.updateSubmitButtonState();
                            },

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFieldCustom(
                      isShow: true,
                      readOnly: true,
                      hintText: AppString.selectDate,
                      title: AppString.date,
                      fillColor: AppColors.transparent,
                      controller: addWorkLogController.dateController,
                      onTap: () async {
                        DateTime? pickedDate =
                            await addWorkLogController.selectDate(context);
                        if (pickedDate != null) {
                          addWorkLogController.setStartDate(pickedDate);
                          addWorkLogController.updateSubmitButtonState();
                        }
                      },
                      showSuffixIcon: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          TablerIcons.calendar,
                        ),
                      ),
                    ),
                    WorkLogDescriptionField(
                      focusNode: addWorkLogController.focusNode,
                      controller: addWorkLogController.quillController,
                      isFocused: addWorkLogController.isFocused,
                      isEodShow: addWorkLogController.isEodShow,
                      isRequired: true,
                      onTap: () {
                        log("selected project id is: ${addWorkLogController.selectedProjectId}");
                        Get.toNamed(Routes.projectTaskDetails,
                            arguments: {'id': addWorkLogController.selectedProjectId});
                      },
                      onPaste: () async {
                        try {
                          ClipboardData? clipboardData =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          if (clipboardData?.text?.isNotEmpty == true) {
                            final Delta delta =
                                HtmlToDelta().convert(clipboardData?.text ?? '');
                            addWorkLogController.quillController.document =
                                Document.fromDelta(delta);
                            addWorkLogController.updateSubmitButtonState();
                          } else {
                            log('Clipboard is empty.');
                          }
                        } catch (e) {
                          log('Error retrieving clipboard data: $e');
                        }
                      },
                    ),
                    ButtonUi(
                      onPressedSubmit: () {
                        if (addWorkLogController.isFromEdit == true) {
                          addWorkLogController
                              .editProjectWorklog(addWorkLogController.taskId);
                        } else {
                          addWorkLogController.addProjectWorklog();
                        }
                      },
                      isEnable: addWorkLogController.isFormValid,
                      isLoading: addWorkLogController.isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
