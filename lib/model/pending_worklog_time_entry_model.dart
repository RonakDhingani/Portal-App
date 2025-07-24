class PendingWorklogTimeEntryModel {
  List<String>? pendingWorkLogs;
  List<String>? pendingTimeEntry;

  PendingWorklogTimeEntryModel({this.pendingWorkLogs, this.pendingTimeEntry});

  PendingWorklogTimeEntryModel.fromJson(Map<String, dynamic> json) {
    pendingWorkLogs = json['pending_work_logs'].cast<String>();
    pendingTimeEntry = json['pending_time_entry'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending_work_logs'] = this.pendingWorkLogs;
    data['pending_time_entry'] = this.pendingTimeEntry;
    return data;
  }
}
