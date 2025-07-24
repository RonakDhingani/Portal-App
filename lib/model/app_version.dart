class AppVersion {
  final String id;
  final String newVersion;
  final String oldVersion;
  final String updateTitle;
  final String updateSubtitle;

  AppVersion({
    required this.id,
    required this.newVersion,
    required this.oldVersion,
    required this.updateTitle,
    required this.updateSubtitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'newVersion': newVersion,
      'oldVersion': oldVersion,
      'updateTitle': updateTitle,
      'updateSubtitle': updateSubtitle,
    };
  }

  factory AppVersion.fromMap(Map<String, dynamic> map, String id) {
    return AppVersion(
      id: id,
      newVersion: map['newVersion'] ?? '',
      oldVersion: map['oldVersion'] ?? '',
      updateTitle: map['updateTitle'] ?? '',
      updateSubtitle: map['updateSubtitle'] ?? '',
    );
  }
}