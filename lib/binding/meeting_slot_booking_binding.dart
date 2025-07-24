import 'package:get/get.dart';

import '../controller/meeting_slot_booking_controller.dart';


class MeetingSlotBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingSlotBookingController>(
          () => MeetingSlotBookingController(),
    );
  }
}