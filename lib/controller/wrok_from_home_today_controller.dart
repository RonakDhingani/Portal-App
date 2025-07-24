
import 'package:get/get.dart';
import '../model/work_from_home_today_model.dart';

class WorkFromHomeTodayController extends GetxController{
  bool isLoading = false;
  int page = 1;
  int pageSize = 0;
  int currentIndex = 0;
  String filter = '';
  WorkFromHomeTodayModel? workFromHomeTodayModel;


  WorkFromHomeTodayController() {
    isLoading = true;
    update();
    final arguments = Get.arguments;
    workFromHomeTodayModel = arguments['workFromHomeData'];
    isLoading = false;
    update();
    printWorkFromHomeTodayData();
  }

  void printWorkFromHomeTodayData() {
    if (workFromHomeTodayModel != null) {
      List<Result>? results = workFromHomeTodayModel?.result;
      for (int i = 0; i < results!.length; i++) {
        print('Result ${i + 1}: ${results[i].requestFrom}');
      }
    } else {
      print('Work from home today data is null.');
    }
  }

}