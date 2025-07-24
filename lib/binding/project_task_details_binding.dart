import 'package:get/get.dart';
import 'package:inexture/controller/project_task_details_controller.dart';

class ProjectTaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectTaskDetailsController>(
      () => ProjectTaskDetailsController(),
    );
  }
}
