import 'package:get/get.dart';
import 'package:inexture/model/upcoming_leave_model.dart';

class UpcomingLeaveController extends GetxController {
  bool isLoading = false;
  int page = 1;
  int pageSize = 0;
  int currentIndex = 0;
  String filter = '';
  UpcomingLeaveModel? upcomingLeaveModel;

  UpcomingLeaveController() {
    isLoading = true;
    update();
    final arguments = Get.arguments;
    upcomingLeaveModel = arguments['upcomingLeave'];
    isLoading = false;
    update();
    printWorkFromHomeTodayData();
  }

  void printWorkFromHomeTodayData() {
    if (upcomingLeaveModel != null) {
      List<Results>? results = upcomingLeaveModel?.results;
      for (int i = 0; i < results!.length; i++) {
        print('Result ${i + 1}: ${results[i].requestFrom}');
      }
    } else {
      print('Work from home today data is null.');
    }
  }
}
