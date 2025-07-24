part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const mainHome = _Paths.mainHome;
  static const home = _Paths.home;
  static const profile = _Paths.profile;
  static const personalInformation = _Paths.personalInformation;
  static const services = _Paths.services;
  static const holidays = _Paths.holidays;
  static const policies = _Paths.policies;
  static const project = _Paths.project;
  static const leave = _Paths.leave;
  static const leaveToday = _Paths.leaveToday;
  static const upcomingLeave = _Paths.upcomingLeave;
  static const myWorkFromHome = _Paths.myWorkFromHome;
  static const workFromHomeToday = _Paths.workFromHomeToday;
  static const timeEntry = _Paths.timeEntry;
  static const taskDashBoard = _Paths.taskDashBoard;
  static const addLeave = _Paths.addLeave;
  static const addWorkFromHome = _Paths.addWorkFromHome;
  static const projectTaskDetails = _Paths.projectTaskDetails;
  static const addWorkLog = _Paths.addWorkLog;
  static const gameZone = _Paths.gameZone;
  static const meeting = _Paths.meeting;
  static const gameZoneSlotBooking = _Paths.gameZoneSlotBooking;
  static const gameBooking = _Paths.gameBooking;
  static const chatWithAi = _Paths.chatWithAi;
  static const meetingSlotBooking = _Paths.meetingSlotBooking;
  static const goToSomewhere = _Paths.goToSomewhere;
  static const premiumUsers = _Paths.premiumUsers;
}

abstract class _Paths {
  _Paths._();

  static const splash = '/splash';
  static const login = '/login';
  static const mainHome = '/mainHome';
  static const home = '/home';
  static const profile = '/profile';
  static const personalInformation = '/personalInformation';
  static const services = '/services';
  static const holidays = '/holidays';
  static const policies = '/policies';
  static const project = '/project';
  static const leave = '/leave';
  static const leaveToday = '/leaveToday';
  static const upcomingLeave = '/upcomingLeave';
  static const myWorkFromHome = '/myWorkFromHome';
  static const workFromHomeToday = '/workFromHomeToday';
  static const timeEntry = '/timeEntry';
  static const taskDashBoard = '/taskDashBoard';
  static const addLeave = '/addLeave';
  static const addWorkFromHome = '/addWorkFromHome';
  static const projectTaskDetails = '/projectTaskDetails';
  static const addWorkLog = '/addWorkLog';
  static const gameZone = '/gameZone';
  static const meeting = '/meeting';
  static const gameZoneSlotBooking = '/gameZoneSlotBooking';
  static const gameBooking = '/gameBooking';
  static const chatWithAi = '/chatWithAi';
  static const meetingSlotBooking = '/meetingSlotBooking';
  static const goToSomewhere = '/goToSomewhere';
  static const premiumUsers = '/premiumUsers';
}
