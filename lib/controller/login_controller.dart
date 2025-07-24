import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widget/api_url.dart';
import '../common_widget/global_value.dart';
import '../model/login_model.dart';
import '../model/stored_user_model.dart';
import '../routes/app_pages.dart';
import '../services/api_function.dart';
import '../services/firebase_operation.dart';
import '../utils/utility.dart';

class LoginController extends GetxController {
  bool isShow = false;
  bool isForget = false;
  bool isDark = false;
  bool isLoading = false;
  bool isFromAddAccount = false;
  bool isForGetPass = false;
  bool isSupported = false;
  String errorText = '';
  LoginUserModel? loginUserModel;
  final storage = FlutterSecureStorage();
  final userListKey = 'stored_users';
  final formKey = GlobalKey<FormState>();
  final formForgotPassWordKey = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserService userService = UserService();
  final Connectivity connectivity = Connectivity();
  final StreamController<String> connectivityStatusController =
      StreamController<String>.broadcast();

  Stream<String> get connectivityStatusStream =>
      connectivityStatusController.stream;
  bool _firstTime = true;

  @override
  void onInit() {
    isFromAddAccount = Get.arguments?['isFromAddAccount'] ?? false;
    update();
    getInitialConnectivityStatus().then(
      (value) {},
    );
    connectivity.onConnectivityChanged.listen(
      (event) {
        if (_firstTime) {
          _firstTime = false;
          return;
        }
        var status = checkConnectivityStatus(event);
        connectivityStatusController.add(status.toString());
      },
    );
    auth.isDeviceSupported().then((bool supported) {
      isSupported = supported;
      update();
    });
    super.onInit();
  }

  Future<String> getInitialConnectivityStatus() async {
    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    return checkConnectivityStatus(result);
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';
      update();

      authenticated = await auth.authenticate(
        localizedReason: Platform.isIOS
            ? 'Use Face ID, Touch ID, or passcode'
            : 'Use fingerprint, face, or device credentials',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      isAuthenticating = false;
    } on PlatformException catch (e) {
      isAuthenticating = false;
      authorized = 'Error - ${e.message}';
      update();
      return;
    }

    if (authenticated) {
      await identifyUserFromStoredCredentials();
    } else {
      authorized = 'Not Authorized';
      update();
    }
  }

  Future<void> identifyUserFromStoredCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('storedUsername');
    String? storedPassword = prefs.getString('storedPassword');

    if (storedUsername != null && storedPassword != null) {
      userNameController.text = storedUsername;
      passwordController.text = storedPassword;
      await login(isFromBiometrics: true);
    } else {
      Utility.showFlushBar(
        text: 'No user data stored. Please login manually first.',
        color: AppColors.redd,
      );
    }
  }

  Future<void> login({bool isFromBiometrics = false}) async {
    log("loginuserid : ${userNameController.text}");
    log("loginuserpass : ${passwordController.text}");
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiFunction.apiRequest(
      url: ApiUrl.loginUrl,
      method: 'POST',
      data: dio.FormData.fromMap({
        "username": userNameController.text,
        "password": passwordController.text,
      }),
      headers: {
        "Content-Type":
            'multipart/form-data; boundary=<calculated when request is sent>',
      },
      onSuccess: (value) async {
        accessToken = value.data['access'];
        refreshToken = value.data['refresh'];
        prefs.setString('accessToken', accessToken);
        prefs.setString('refreshToken', refreshToken);

        if (!isFromBiometrics) {
          prefs.setString('storedUsername', userNameController.text);
          prefs.setString('storedPassword', passwordController.text);
        }
        loginUserModel = LoginUserModel.fromJson(value.data);
        isLoading = false;
        update();
        Get.offAllNamed(Routes.mainHome);
        await userService.addUser(
            fireUserName:
                "${loginUserModel?.firstName} ${loginUserModel?.lastName}",
            fireUserID: userNameController.text,
            password: passwordController.text);
        addUser(loginData: loginUserModel ?? LoginUserModel());
        userNameController.clear();
        passwordController.clear();
        return TextInput.finishAutofillContext();
      },
      onError: (response) {
        isLoading = false;
        update();
        Utility.showFlushBar(
          text: response.data['error']['message'][0].toString(),
          color: AppColors.redd,
        );
        log('Login API Error : ${response.data.toString()}');
      },
    );
  }

  Future<void> forGetPassword() async {
    log("email : ${emailController.text}");
    isForGetPass = true;
    update();

    ApiFunction.apiRequest(
      url: ApiUrl.forGetPassword,
      method: 'POST',
      data: dio.FormData.fromMap({"email": emailController.text}),
      headers: {
        "Content-Type":
            'multipart/form-data; boundary=<calculated when request is sent>',
      },
      onSuccess: (value) async {
        Utility.showFlushBar(
          text: value.data['message'].toString(),
          color: AppColors.greenn,
        );
        isForGetPass = false;
        isForget = false;
        Utility.hideKeyboard(Get.context!);
        emailController.clear();
        update();
      },
      onError: (response) {
        isForGetPass = false;
        update();
        Utility.showFlushBar(
          text: response.data['error']['message']['validation_error'][0]
              .toString(),
          color: AppColors.redd,
        );
        log('ForGet Password API Error : ${response.data.toString()}');
      },
    );
  }

  Future<void> addUser({required LoginUserModel loginData}) async {
    String name = '${loginData.firstName} ${loginData.lastName}';

    if (isFromAddAccount == false) {
      if (!users.contains(name)) return;
    }
    List<StoredUser> userList = await getStoredUsers();
    bool alreadyExists = userList.any((u) => u.email == loginData.email);

    // Unset all others as current
    userList = userList.map((u) => u.copyWith(isCurrent: false)).toList();

    if (!alreadyExists) {
      StoredUser newUser = StoredUser(
        name: name,
        email: loginData.email!,
        accessToken: loginData.access!,
        refreshToken: loginData.refresh!,
        image: loginData.image ?? '',
        isCurrent: true,
      );
      userList.add(newUser);
    } else {
      userList = userList
          .map((u) => u.copyWith(isCurrent: u.email == loginData.email))
          .toList();
    }

    await storage.write(
      key: userListKey,
      value: jsonEncode(userList.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<StoredUser>> getStoredUsers() async {
    String? raw = await storage.read(key: userListKey);
    if (raw == null) return [];
    List data = jsonDecode(raw);
    return data.map((e) => StoredUser.fromJson(e)).toList();
  }
}
