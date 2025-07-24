import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/api_url.dart';
import '../common_widget/app_colors.dart';
import '../model/all_active_user_model.dart';
import '../services/api_function.dart';
import '../services/firebase_operation.dart';
import '../utils/utility.dart';

class PremiumUsersController extends GetxController {
  final UserService userService = UserService();
  bool isLoading = false;
  AllActiveUserModel? allActiveUserModel;
  List<Data> selectedUsers = [];
  List<PremiumUser> alreadyPremiumUsers = [];
  bool isSelectionMode = false;
  final TextEditingController searchField = TextEditingController();
  List<Data> filteredUsers = <Data>[];

  @override
  void onInit() {
    searchField.addListener(filterUsers);
    getAllUser();
    fetchExistingPremiumUsers();
    super.onInit();
  }

  void filterUsers() {
    final query = searchField.text.toLowerCase();
    final allUsers = allActiveUserModel?.data ?? [];

    if (query.isEmpty) {
      filteredUsers = allUsers;
    } else {
      filteredUsers = allUsers
          .where((user) => '${user.firstName} ${user.lastName}'
              .toLowerCase()
              .contains(query))
          .toList();
    }
    update();
  }

  Future<void> fetchExistingPremiumUsers() async {
    try {
      QuerySnapshot snapshot = await userService.premiumUsersCollection.get();
      alreadyPremiumUsers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PremiumUser(
          name: data['Name'] as String,
          docId: doc.id,
        );
      }).toList();
      log("🔥 Already Premium Users Count: ${alreadyPremiumUsers.length}");
      for (var user in alreadyPremiumUsers) {
        log("🔥 Already Premium Users:  name: ${user.name} - ${user.docId}");
      }
    } catch (e) {
      log("Error fetching existing premium users: $e");
    }
    update();
  }

  void toggleSelection(Data user) {
    if (selectedUsers.contains(user)) {
      selectedUsers.remove(user);
      if (selectedUsers.isEmpty) {
        isSelectionMode = false;
      }
    } else {
      selectedUsers.add(user);
      isSelectionMode = true;
    }
  }

  Future<void> saveUsersToFirebase(List<Data> usersToAdd) async {
    for (var user in usersToAdd) {
      final fullName = "${user.firstName} ${user.lastName}";
      if (!alreadyPremiumUsers.any((e) => e.name == fullName)) {
        await userService.addPremiumUser(fullUserName: fullName);
      }
    }
    await fetchExistingPremiumUsers();
  }

  Future<void> removeUsersFromFirebase(List<Data> usersToDelete) async {
    for (var user in usersToDelete) {
      final fullName = "${user.firstName} ${user.lastName}";
      final match =
          alreadyPremiumUsers.firstWhereOrNull((e) => e.name == fullName);
      if (match != null) {
        await userService.deletePremiumUser(docId: match.docId,name: match.name);
      }
    }
    await fetchExistingPremiumUsers();
  }

  void cancelSelection() {
    selectedUsers.clear();
    isSelectionMode = false;
    update();
  }

  Future<void> getAllUser() async {
    isLoading = true;
    update();
    ApiFunction.apiRequest(
      url: '${ApiUrl.allActiveUser}?public_access=true',
      method: 'GET',
      onSuccess: (value) {
        log(value.statusCode.toString());
        log(value.realUri.toString());
        log(value.statusMessage.toString());
        log('All Active User API Response : ${value.data.toString()}');
        allActiveUserModel = AllActiveUserModel.fromJson(value.data);
        allActiveUserModel?.data?.sort((a, b) =>
            ('${a.firstName} ${a.lastName}')
                .toLowerCase()
                .compareTo(('${b.firstName} ${b.lastName}').toLowerCase()));

        filteredUsers = allActiveUserModel?.data ?? [];
        isLoading = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then((value) => getAllUser());
      },
      onError: (value) {
        log('Get All Users API Error : ${value.data.toString()}');
        Utility.showFlushBar(
          text: value.data['error']['message'],
          color: AppColors.redd,
        );
        isLoading = false;
        update();
      },
    );
  }
}

class PremiumUser {
  final String name;
  final String docId;

  PremiumUser({required this.name, required this.docId});
}
