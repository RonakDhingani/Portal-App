import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeFormatController extends GetxController {
  RxBool showOriginal = false.obs;

  @override
  @override
  void onInit() {
    getShowOriginal();
    super.onInit();
  }

  Future<void> toggleShowOriginal({required var value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showOriginal.value = value;
    await prefs.setBool('showOriginal', showOriginal.value);
    update();
  }

  Future<void> getShowOriginal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showOriginal.value = prefs.getBool('showOriginal') ?? false;
    update();
  }
}
