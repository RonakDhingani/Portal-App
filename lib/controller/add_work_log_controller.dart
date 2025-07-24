// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'dart:developer';

import 'package:delta_to_html/delta_to_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/controller/task_controller.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../common_widget/text.dart';
import '../model/my_task_project_model.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';
import 'main_home_controller.dart';

class AddWorkLogController extends GetxController {
  bool isLoading = false;
  bool isFromEdit = false;
  bool isFormValid = false;
  bool isEodShow = false;
  bool isFromHome = false;
  bool isFocused = false;
  var selectedProject = '';
  var selectedProjectId = '';
  var selectedTask = '';
  var selectedHours = '';
  var selectedMinutes = '';
  var workDescription = '';
  var selectedDate;
  int taskId = 0;
  final FocusNode focusNode = FocusNode();
  final TextEditingController dateController = TextEditingController();
  final ScrollController containerScrollController = ScrollController();
  QuillController quillController = QuillController.basic();
  var taskController = Get.find<TaskController>();
  final addWorkLogFormKey = GlobalKey<FormState>();
  String? date;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(onFocusChange);
    quillController.document.changes.listen((event) {
      updateSubmitButtonState();
    });

    final arguments = Get.arguments;
    date = arguments['date'];
    dateController.text = Global.formatDate(date.toString().split(' ')[0]);

    taskId = arguments['taskId'] ?? 0;

    isFromEdit = arguments['isFromEdit'] ?? false;
    isFromHome = arguments['isFromHome'] ?? false;

    String project = arguments['project'] ?? '';
    if (project.isNotEmpty) {
      setSelectedProject(project);
    }
    String task = arguments['task'] ?? '';
    if (task.isNotEmpty) {
      setSelectedTask(task);
    }
    String hours = arguments['hours'] ?? '';
    if (hours.isNotEmpty) {
      processHours(hours);
    }
    String workDescription = arguments['workDescription'] ?? '';
    if (workDescription.isNotEmpty) {
      final Delta delta = HtmlToDelta().convert(workDescription);
      quillController.document = Document.fromDelta(delta);
    }
    updateSubmitButtonState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    containerScrollController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    focusNode.dispose();
    containerScrollController.dispose();
    super.onClose();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      isFocused = true;
      Future.delayed(Duration(milliseconds: 300), () {
        containerScrollController.animateTo(
          containerScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
        return update();
      });
    } else {
      isFocused = false;
      update();
    }
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    DateTime firstDate = DateTime(now.year - 1, now.month, now.day);

    DateTime initialDate;

    if (date != null) {
      DateTime? parsedDate = DateTime.tryParse(date ?? '');
      initialDate =
          parsedDate != null && parsedDate.isBefore(now) ? parsedDate : now;
    } else {
      initialDate = now;
    }

    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.yelloww,
              onPrimary: AppColors.whitee,
              onSurface: AppColors.blackk,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.yelloww,
                textStyle:
                    CommonText.style500S15.copyWith(color: AppColors.blackk),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  List<String> getProjectNames() {
    return taskController.allProjectResults
        .map((project) => project.projectName ?? '')
        .toSet()
        .toList();
  }

  List<String> getTaskNames(String projectName) {
    return projectName.isEmpty
        ? []
        : taskController.allProjectResults
            .where((project) => project.projectName == projectName)
            .map(
              (project) => project.taskName ?? '',
            )
            .toList();
  }

  void setSelectedProject(String projectName) {
    selectedProject = projectName;
    selectedTask = '';
    updateSubmitButtonState();
  }

  void setSelectedTask(String taskName) {
    selectedTask = taskName;

    final matchedTask = taskController.allProjectResults.firstWhere(
      (project) => project.taskName == taskName,
      orElse: () => Results(),
    );

    selectedProjectId = matchedTask.id?.toString() ?? "";
    log('Selected Project ID: $selectedProjectId');
    if (isFromEdit == true) {
      isEodShow = false;
    } else {
      isEodShow = true;
    }
    updateSubmitButtonState();
  }

  void setSelectedHours(String hours) {
    selectedHours = hours;
    updateSubmitButtonState();
  }

  void setSelectedMinutes(String minutes) {
    selectedMinutes = minutes;
    updateSubmitButtonState();
  }

  void processHours(String hours) {
    print('hour value: $hours');
    List<String> parts = hours.split('.');
    if (parts.length == 2) {
      String hoursString = parts[0];
      String minutesString = parts[1];
      setSelectedHours(hoursString);
      setSelectedMinutes(minutesString);
    } else {
      print('Invalid hours format: $hours');
    }
  }

  Future<void> addProjectWorklog() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: ApiUrl.projectWorklog,
      method: 'POST',
      data: {
        "user": userId,
        "task": selectedProjectId,
        "log_date": "${Global.formatSelectedDate(dateController.text)}",
        "log_time_hours": "$selectedHours",
        "log_time_minutes": "$selectedMinutes",
        "work_description":
            "${DeltaToHTML.encodeJson(quillController.document.toDelta().toJson())}"
      },
      onSuccess: (value) async {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Project Worklog API Response : ${value.data.toString()}');
        update();
        if (isFromHome == true) {
          Get.find<MainHomeController>().getPendingWorklogTimeEntry();
        }
        Global.addTaskSound().then(
          (value) {
            isLoading = false;
            Get.back(result: "Added");
          },
        );
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => addProjectWorklog(),
        );
      },
      onError: (value) {
        log('Project Worklog API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        update();
      },
    );
  }

  Future<void> editProjectWorklog(int indexId) async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.projectWorklog}/$indexId',
      method: 'PUT',
      data: {
        "id": indexId,
        "user": userId,
        "task": selectedProjectId,
        "log_date": "${Global.formatSelectedDate(dateController.text)}",
        "log_time_hours": "$selectedHours",
        "log_time_minutes": "$selectedMinutes",
        "work_description":
            "${DeltaToHTML.encodeJson(quillController.document.toDelta().toJson())}"
      },
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('Edit Project Worklog API Response : ${value.data.toString()}');
        Global.addTaskSound().then(
          (value) {
            isLoading = false;
            update();
            Get.back(result: "Added");
          },
        );
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => addProjectWorklog(),
        );
      },
      onError: (value) {
        log('Edit Project Worklog API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading = false;
        update();
      },
    );
  }

  void setStartDate(DateTime date) {
    selectedDate = date.toString().split(' ')[0];
    dateController.text = Global.formatDate(date.toString().split(' ')[0]);
    updateSubmitButtonState();
  }

  void updateSubmitButtonState() {
    isFormValid = selectedProject.isNotEmpty &&
        selectedTask.isNotEmpty &&
        (selectedHours.isNotEmpty || selectedMinutes.isNotEmpty) &&
        dateController.text.isNotEmpty &&
        quillController.document.toPlainText().trim().isNotEmpty;
    update();
  }
}
