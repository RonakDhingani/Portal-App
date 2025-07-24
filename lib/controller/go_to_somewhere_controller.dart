import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/app_user_model.dart';
import '../services/firebase_operation.dart';

class GoToSomewhereController extends GetxController {
  bool isLoading = false;
  final TextEditingController searchField = TextEditingController();
  final UserService userService = UserService();
  List<AppUser> users = [];
  List<AppUser> originalUsers = [];
  Map<String, List<AppUser>> groupedUsers = {};

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  void fetchAllUsers() async {
    isLoading = true;
    update();
    final fetchedUsers = await userService.getAllUsers();
    fetchedUsers.sort((a, b) =>
        a.fireUserName.toLowerCase().compareTo(b.fireUserName.toLowerCase()));

    isLoading = false;
    users = fetchedUsers;
    originalUsers = List.from(fetchedUsers);
    groupUsersAlphabetically();
    update();
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      users = List.from(originalUsers);
    } else {
      final lowerQuery = query.toLowerCase();
      final filtered = originalUsers
          .where((user) =>
              user.fireUserName.toLowerCase().contains(lowerQuery) ||
              user.fireUserID.toLowerCase().contains(lowerQuery))
          .toList();

      filtered.sort((a, b) {
        final aName = a.fireUserName.toLowerCase();
        final bName = b.fireUserName.toLowerCase();
        if (aName.startsWith(lowerQuery) && !bName.startsWith(lowerQuery)) {
          return -1;
        } else if (!aName.startsWith(lowerQuery) &&
            bName.startsWith(lowerQuery)) {
          return 1;
        }
        return aName.compareTo(bName);
      });

      users = filtered;
    }
    groupUsersAlphabetically();
    update();
  }

  void groupUsersAlphabetically() {
    groupedUsers.clear();
    for (var user in users) {
      String firstLetter = user.fireUserName[0].toUpperCase();
      if (!groupedUsers.containsKey(firstLetter)) {
        groupedUsers[firstLetter] = [];
      }
      groupedUsers[firstLetter]!.add(user);
    }

    // Optional: sort inner user lists alphabetically
    groupedUsers.forEach((key, list) {
      list.sort((a, b) => a.fireUserName.compareTo(b.fireUserName));
    });

    // Optional: Sort section keys
    groupedUsers = Map.fromEntries(
        groupedUsers.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));

    update();
  }
}
