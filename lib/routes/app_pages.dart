// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:inexture/binding/add_leave_binding.dart';
import 'package:inexture/binding/add_work_from_home_binding.dart';
import 'package:inexture/binding/game_zone_slot_booking_binding.dart';
import 'package:inexture/binding/go_to_somewhere_binding.dart';
import 'package:inexture/binding/holidays_binding.dart';
import 'package:inexture/binding/home_binding.dart';
import 'package:inexture/binding/leave_binding.dart';
import 'package:inexture/binding/my_work_from_home_binding.dart';
import 'package:inexture/binding/personal_information_binding.dart';
import 'package:inexture/binding/policies_binding.dart';
import 'package:inexture/binding/project_bining.dart';
import 'package:inexture/binding/project_task_details_binding.dart';
import 'package:inexture/binding/services_binding.dart';
import 'package:inexture/binding/task_dashboard_binding.dart';
import 'package:inexture/binding/time_entry_binding.dart';
import 'package:inexture/binding/upcoming_leave_binding.dart';
import 'package:inexture/binding/work_from_home_today_binding.dart';
import 'package:inexture/screen/holidays.dart';
import 'package:inexture/screen/home/home.dart';
import 'package:inexture/screen/leave/my_leave/add_leave.dart';
import 'package:inexture/screen/leave/my_leave/leave.dart';
import 'package:inexture/screen/leave/today_leave/leave_today.dart';
import 'package:inexture/screen/leave/upcoming_leave/upcoming_leave.dart';
import 'package:inexture/screen/login.dart';
import 'package:inexture/screen/policies.dart';
import 'package:inexture/screen/premium_users.dart';
import 'package:inexture/screen/profile/profile_second_container/go_to_somewhere.dart';
import 'package:inexture/screen/project.dart';
import 'package:inexture/screen/services.dart';
import 'package:inexture/screen/splash.dart';
import 'package:inexture/screen/task_dashboard/task_dashboard.dart';
import 'package:inexture/screen/venue_booking/game_zone/game_booking.dart';
import 'package:inexture/screen/work_from_home/add_work_from_home.dart';
import 'package:inexture/screen/work_from_home/my_work_from_home.dart';

import '../binding/add_work_log_binding.dart';
import '../binding/chat_with_ai_binding.dart';
import '../binding/game_booking_binding.dart';
import '../binding/game_zone_binding.dart';
import '../binding/leave_today_binding.dart';
import '../binding/login_binding.dart';
import '../binding/main_home_binding.dart';
import '../binding/meeting_slot_booking_binding.dart';
import '../binding/premium_users_binding.dart';
import '../binding/profile_binding.dart';
import '../binding/splash_binding.dart';
import '../screen/add_work_log/add_work_log.dart';
import '../screen/chat_with_ai/chat_with_ai/chat_with_ai.dart';
import '../screen/main_homes/main_home.dart';
import '../screen/profile/personal_information/personal_information.dart';
import '../screen/profile/profile.dart';
import '../screen/project_task_details.dart';
import '../screen/time_entry/time_entry.dart';
import '../screen/venue_booking/game_zone/game_zone.dart';
import '../screen/venue_booking/game_zone/game_zone_slot_booking.dart';
import '../screen/venue_booking/game_zone/meeting_slot_booking.dart';
import '../screen/work_from_home/work_from_home_today.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.mainHome,
      page: () => MainHomeScreen(),
      binding: MainHomeBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => Profile(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.personalInformation,
      page: () => PersonalInformationScreen(),
      binding: PersonalInformationBinding(),
    ),
    GetPage(
      name: _Paths.services,
      page: () => ServicesScreen(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: _Paths.holidays,
      page: () => HolidaysScreen(),
      binding: HolidaysBinding(),
    ),
    GetPage(
      name: _Paths.policies,
      page: () => PoliciesScreen(),
      binding: PoliciesBinding(),
    ),
    GetPage(
      name: _Paths.project,
      page: () => ProjectScreen(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: _Paths.leave,
      page: () => LeaveScreen(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: _Paths.leaveToday,
      page: () => LeaveToday(),
      binding: LeaveTodayBinding(),
    ),
    GetPage(
      name: _Paths.upcomingLeave,
      page: () => UpcomingLeave(),
      binding: UpcomingLeaveBinding(),
    ),
    GetPage(
      name: _Paths.myWorkFromHome,
      page: () => MyWorkFromHomeScreen(),
      binding: MyWorkFromHomeBinding(),
    ),
    GetPage(
      name: _Paths.workFromHomeToday,
      page: () => WorkFromHomeToday(),
      binding: WorkFromHomeTodayBinding(),
    ),
    GetPage(
      name: _Paths.taskDashBoard,
      page: () => TaskDashboardScreen(),
      binding: TaskDashboardBinding(),
    ),
    GetPage(
      name: _Paths.timeEntry,
      page: () => TimeEntryScreen(),
      binding: TimeEntryBinding(),
    ),
    GetPage(
      name: _Paths.addLeave,
      page: () => AddLeave(),
      binding: AddLeaveBinding(),
    ),
    GetPage(
      name: _Paths.addWorkFromHome,
      page: () => AddWorkFromHome(),
      binding: AddWorkFromHomeBinding(),
    ),
    GetPage(
      name: _Paths.projectTaskDetails,
      page: () => ProjectTaskDetails(),
      binding: ProjectTaskDetailsBinding(),
    ),
    GetPage(
      name: _Paths.addWorkLog,
      page: () => AddWorkLog(),
      binding: AddWorkLogBinding(),
    ),
    GetPage(
      name: _Paths.gameZone,
      page: () => GameZone(),
      binding: GameZoneBinding(),
    ),
    GetPage(
      name: _Paths.gameZoneSlotBooking,
      page: () => GameZoneSlotBooking(),
      binding: GameZoneSlotBookingBinding(),
    ),
    GetPage(
      name: _Paths.gameBooking,
      page: () => GameBooking(),
      binding: GameBookingBinding(),
    ),
    GetPage(
      name: _Paths.chatWithAi,
      page: () => ChatWithAi(),
      binding: ChatWithAiBinding(),
    ),
    GetPage(
      name: _Paths.meetingSlotBooking,
      page: () => MeetingSlotBooking(),
      binding: MeetingSlotBookingBinding(),
    ),
    GetPage(
      name: _Paths.goToSomewhere,
      page: () => GoToSomewhere(),
      binding: GoToSomewhereBinding(),
    ),
    GetPage(
      name: _Paths.premiumUsers,
      page: () => PremiumUsers(),
      binding: PremiumUsersBinding(),
    ),
  ];
}
