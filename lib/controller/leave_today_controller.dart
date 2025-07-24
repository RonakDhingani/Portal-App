import 'package:get/get.dart';

import '../model/employee_on_leave_today_model.dart';

class LeaveTodayController extends GetxController{
  bool isLoading = false;
  int page = 1;
  int pageSize = 0;
  int currentIndex = 0;
  String filter = '';
  EmployeeOnLeaveTodayModel? employeeOnLeaveTodayModel;


  LeaveTodayController() {
    isLoading = true;
    update();
    final arguments = Get.arguments;
    employeeOnLeaveTodayModel = arguments['leaveToday'];
    isLoading = false;
    update();
    printWorkFromHomeTodayData();
  }

  void printWorkFromHomeTodayData() {
    if (employeeOnLeaveTodayModel != null) {
      List<Results>? results = employeeOnLeaveTodayModel?.results;
      for (int i = 0; i < results!.length; i++) {
        print('Result ${i + 1}: ${results[i].requestFrom?.firstName}');
      }
    } else {
      print('Work from home today data is null.');
    }
  }

}