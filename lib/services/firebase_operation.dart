import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widget/global_value.dart';
import '../model/app_user_model.dart';
import '../model/app_version.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference premiumUsersCollection =
      FirebaseFirestore.instance.collection("premium_users");
  final CollectionReference appVersionCollection =
      FirebaseFirestore.instance.collection("app_version");

  /// 🔹 Add New User
  Future<void> addUser({
    required String fireUserName,
    required String fireUserID,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if user already exists
    final existingUsers = await userCollection
        .where('fireUserName', isEqualTo: fireUserName)
        .where('fireUserID', isEqualTo: fireUserID)
        .get();

    if (existingUsers.docs.isNotEmpty) {
      log("User already exists. Skipping add.");
      return; // Don't add duplicate
    }

    // If not found, add new user
    DocumentReference docRef = await userCollection.add({
      'fireUserName': fireUserName,
      'fireUserID': fireUserID,
      'password': password,
    });
    prefs.setString('docRefID', docRef.id);
    log("User created with ID: ${docRef.id}");
  }

  /// 🔹 Edit User Data
  Future<void> updateUser({
    required String docRefID,
    required String fireUserName,
    required String fireUserID,
    required String password,
  }) async {
    await userCollection.doc(docRefID).update({
      'fireUserName': fireUserName,
      'fireUserID': fireUserID,
      'password': password,
    }).then((_) {
      log("User updated successfully - $docRefID");
    }).catchError((error) {
      log("Failed to update user: $error - $docRefID");
    });
  }

  Future<List<AppUser>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await userCollection.get();
      return snapshot.docs.map((doc) {
        return AppUser.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      log("Error fetching users: $e");
      return [];
    }
  }

  Future<AppVersion?> getAppVersion() async {
    try {
      final snapshot = await appVersionCollection.limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return AppVersion.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        log("No app version found.");
        return null;
      }
    } catch (e) {
      log("Error fetching app version: $e");
      return null;
    }
  }

  Future<List<String>> getPremiumUserNames() async {
    try {
      QuerySnapshot snapshot = await premiumUsersCollection.get();
      users.clear();
      for (var doc in snapshot.docs) {
        final name = doc.get('Name');
        log('Name: $name');
        users.add(name);
      }
      log("Premium user names fetched successfully: $users");
      return users;
    } catch (e) {
      log("Error fetching user names: $e");
      return [];
    }
  }

  Future<void> addPremiumUser({required String fullUserName}) async {
    try {
      final existingUsers = await premiumUsersCollection
          .where('Name', isEqualTo: fullUserName)
          .get();

      if (existingUsers.docs.isNotEmpty) {
        log("User already exists: $fullUserName. Skipping add.");
        return;
      }

      await premiumUsersCollection.add({"Name": fullUserName});
      log("✅ User added: $fullUserName");
    } catch (e) {
      log("❌ Error adding premium user: $e");
    }
  }

  Future<void> deletePremiumUser({required String docId, String? name}) async {
    try {
      await premiumUsersCollection.doc(docId).delete();
      log("🗑️ Deleted premium user with docId: $docId, Name: $name");
    } catch (e) {
      log("❌ Error deleting premium user: $e");
    }
  }

  Future<void> deleteAllUsers() async {
    try {
      QuerySnapshot snapshot = await userCollection.get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await userCollection.doc(doc.id).delete();
        log("Deleted user: ${doc.id}");
      }
      log("All users deleted successfully.");
    } catch (e) {
      log("Error deleting users: $e");
    }
  }
}
