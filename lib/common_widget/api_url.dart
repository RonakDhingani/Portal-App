/*==================<Api Constant>====================*/
class ApiUrl {
  // Base Url
  static const String live = "https://api.portal.inexture.com/api/v1/";
  static const String dev = "https://api.dev.portal.inexture.com/api/v1/";

  static const String baseUrl = live;

  // Other Url
  static const String loginUrl = "${baseUrl}auth/login";
  static const String logoutUrl = "${baseUrl}auth/logout";
  static const String forGetPassword = "${baseUrl}auth/send-password-reset-email/";
  static const String userProfile = "${baseUrl}users/profile/";
  static const String userProfileDetails = "${baseUrl}users/my_profile/";
  static const String userInformation = "${baseUrl}users/user-information/";
  static const String holidays = "${baseUrl}holidays/";
  static const String policies = "${baseUrl}policies/";
  static const String changePassword = "${baseUrl}auth/change-password";
  static const String leaves = "${baseUrl}leaves/user-leaves/";
  static const String createAddLeaves = "${baseUrl}leaves/create-add-on-leave/";
  static const String project = "${baseUrl}policies/";
  static const String timeEntry = "${baseUrl}policies/";
  static const String taskDashBoard = "${baseUrl}policies/";
  static const String projectList = "${baseUrl}project/project-list/";
  static const String employeeOnLeaveToday = "${baseUrl}leaves/dashboard/employee-on-leave-today";
  static const String upcomingLeave = "${baseUrl}leaves/dashboard/upcoming-leave";
  static const String myDashboardLeave = "${baseUrl}leaves/dashboard/my-leaves";
  static const String myLeaves = "${baseUrl}leaves/my-leaves";
  static const String leavesLeaveRequest = "${baseUrl}leaves/leave-request";
  static const String leaveCancel = "${baseUrl}leaves/my-leaves-cancel";
  static const String myLeaveComment = "${baseUrl}leaves/my-leave-comment";
  static const String leaveRequestComment = "${baseUrl}leaves/leave-request-comment";
  static const String myWorkFromHomeComment = "${baseUrl}work-from-home/my-work-from-home-comment/";
  static const String wFHRequestComment = "${baseUrl}work-from-home/receiver-work-from-home-comment/";
  static const String wFHRequestApprove =
      "${baseUrl}work-from-home/team-work-from-home-request-approve-or-reject";
  static const String allEmployeeLeaveReq = "${baseUrl}leaves/all-employee-leave-request";
  static const String workFromHomeToday = "${baseUrl}work-from-home/dashboard/work-from-home-today-list/";
  static const String myWorkFromHome = "${baseUrl}work-from-home/my-work-from-home/";
  static const String cancelWorkFromHome = "${baseUrl}work-from-home/cancel-my-work-from-home";
  static const String workFromHomeRequest = "${baseUrl}work-from-home/receiver-work-from-home/";
  static const String myLiveTimeEntry = "${baseUrl}time-entry/my_live_time_entry";
  static const String myTimeEntry = "${baseUrl}time-entry/my_time_entry";
  static const String employeeTimeEntry = "${baseUrl}time-entry/employee";
  static const String allActiveUser = "${baseUrl}users/all-active-user/";
  static const String workFromHomeRequestTo = "${baseUrl}work-from-home/work-from-home-request-to/";
  static const String variableLeaveSettings = "${baseUrl}settings/variable-leave-settings/";
  static const String dateDurationCalculation = "${baseUrl}settings/return-date-duration-calculation";
  static const String projectMyTasks = "${baseUrl}project/my-tasks";
  static const String projectTasksDetails = "${baseUrl}project/project-task-worklog-listing";
  static const String projectTasksAssignee = "${baseUrl}project/project-task-assignee";
  static const String projectMyWorkLogList = "${baseUrl}project/my-worklog-list";
  static const String projectMyWorklogDateWise = "${baseUrl}project/my-worklog-datewise";
  static const String projectWorklog = "${baseUrl}project/worklog";
  static const String worklogWeeklyEntries = "${baseUrl}project/worklog-weekly-entries";
  static const String userTimeEntry = "${baseUrl}time-entry/dashboard/user_time_entry";
  static const String gameZoneBookedSlot = "${baseUrl}gamezone/?is_active=true&event_choice=";
  static const String gameZoneSlotBooking = "${baseUrl}gamezone/all_game_slots/";
  static const String gameZoneGames = "${baseUrl}gamezone/game/";
  static const String gameUsers = "${baseUrl}gamezone/users/";
  static const String gamezone = "${baseUrl}gamezone/";
  static const String gamezoneDelete = "${baseUrl}gamezone/delete/";
  static const String settingsYearFilter = "${baseUrl}settings/year-filter/";
  static const String refreshToken = "${baseUrl}auth/refresh";
  static const String pendingWorklogTimeEntry = "${baseUrl}project/dashboard/pending-worklog-timeentry/";
  static const String defaulterCount = "${baseUrl}defaulter-management/dahsboard/defaulter_count";
  static const String deleteTaskWorkLog = "${baseUrl}project/worklog/";
  static const String pods = "${baseUrl}pods/";
  static const String teams = "${baseUrl}teams/";
  static const String meetingAreaAvailableList = "${baseUrl}gamezone/meeting_area_available_list/";
  static const String teamStatus = "${baseUrl}users/team-statistics/";
  static const String employeeOfTheMonth = "${baseUrl}employee_of_the_month/current-month-eom";
  static const String todaysBirthdays = "${baseUrl}users/dashboard/todays-birthdays/";
  static const String upcomingBirthdays = "${baseUrl}users/dashboard/upcoming-birthdays/";
  static const String todaysWorkAnniversary = "${baseUrl}users/dashboard/today-work-anniversary";

}

