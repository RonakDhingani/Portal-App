// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widget/app_colors.dart';
import '../common_widget/asset.dart';
import '../common_widget/buttons.dart';
import '../common_widget/textfield.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  @override
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.connectivityStatusStream,
        builder: (context, snapshot) {
          return GetBuilder<LoginController>(
            builder: (loginController) {
              return GestureDetector(
                onTap: () {
                  Utility.hideKeyboard(context);
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          AssetImg.backgroundImg,
                        ),
                      ),
                    ),
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 600) {
                          } else if (constraints.maxWidth < 1200) {
                          } else {}
                          return SingleChildScrollView(
                            child: Form(
                              key: loginController.isForget
                                  ? loginController.formForgotPassWordKey
                                  : loginController.formKey,
                              child: Container(
                                margin: EdgeInsets.all(15),
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                decoration: BoxDecoration(
                                  color: AppColors.whitee,
                                  border: Border.all(
                                      color: AppColors.greyy.withOpacity(0.3)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: AutofillGroup(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          Flexible(
                                            flex: 3,
                                            child: Image(
                                              image:
                                                  AssetImage(AssetImg.inxtImg),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Visibility(
                                        visible: loginController.isForget,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppString.forGotPassword,
                                              style: CommonText.style500S20
                                                  .copyWith(
                                                color: AppColors.blackk,
                                              ),
                                            ),
                                            CommonText.richText(
                                              firstTitle:
                                                  '${AppString.enterYourRegistered}\t',
                                              secTitle: AppString.emailAddress,
                                              color: AppColors.blackk,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFieldCustom(
                                        autofillHints: const [
                                          AutofillHints.username
                                        ],
                                        onChanged: (p0) {
                                          loginController.update();
                                        },
                                        inputAction: TextInputAction.next,
                                        hintText: loginController.isForget
                                            ? AppString.enterEmailAddress
                                            : AppString
                                                .enterUserNameOrEmailAddress,
                                        title: loginController.isForget
                                            ? AppString.emailAddress
                                            : AppString.userNameOrEmailAddress,
                                        controller: loginController.isForget
                                            ? loginController.emailController
                                            : loginController
                                                .userNameController,
                                        isForgetPass: false,
                                        showSuffixIcon: false,
                                        isProgressActive: false,
                                        isShow: true,
                                        validatorText: loginController.isForget
                                            ? AppString.emailIsRequired
                                            : AppString
                                                .pleaseEnterYourUserNameOrEmail,
                                      ),
                                      SizedBox(
                                        height:
                                            loginController.isForget ? 0 : 10,
                                      ),
                                      Visibility(
                                        visible: !loginController.isForget,
                                        child: TextFieldCustom(
                                          autofillHints: const [
                                            AutofillHints.password
                                          ],
                                          onChanged: (p0) {
                                            loginController.update();
                                          },
                                          title: AppString.password,
                                          hintText: AppString.enterPassword,
                                          controller: loginController
                                              .passwordController,
                                          isForgetPass: true,
                                          showSuffixIcon: true,
                                          isProgressActive: false,
                                          isShow: loginController.isShow,
                                          onPressed: () {
                                            loginController.isShow =
                                                !loginController.isShow;
                                            loginController.update();
                                          },
                                          validator: (passCurrentValue) {
                                            var regex = AppString.regExp;
                                            var passNonNullValue =
                                                passCurrentValue ?? "";
                                            if (passNonNullValue.isEmpty) {
                                              return (AppString
                                                  .plsEnterPassword);
                                            } else if (passNonNullValue.length <
                                                8) {
                                              return (AppString
                                                  .errorMinimum8char);
                                            } else if (!regex
                                                .hasMatch(passNonNullValue)) {
                                              return (AppString
                                                  .errorAtLeastULNS);
                                            }
                                            return null;
                                          },
                                          onPressedForget: loginController
                                                  .isLoading
                                              ? null
                                              : () {
                                                  loginController.isForget =
                                                      !loginController.isForget;
                                                  loginController.update();
                                                },
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            loginController.isForget ? 15 : 0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomElevatedButton(
                                            isEnable: loginController.isForget
                                                ? (loginController
                                                        .emailController
                                                        .text
                                                        .isNotEmpty)
                                                    ? true
                                                    : false
                                                : (loginController
                                                            .userNameController
                                                            .text
                                                            .isNotEmpty &&
                                                        loginController
                                                            .passwordController
                                                            .text
                                                            .isNotEmpty)
                                                    ? true
                                                    : false,
                                            txt: loginController.isForget
                                                ? AppString.sendResetLink
                                                : AppString.signIn,
                                            isShowAnimateText: loginController.isForget ? false :true,
                                            isLoading: loginController.isForget ? loginController.isForGetPass :
                                                loginController.isLoading,
                                            onpressed: loginController.isForget
                                                ? () {
                                                    if (loginController
                                                        .formForgotPassWordKey
                                                        .currentState!
                                                        .validate()) {
                                                     loginController.forGetPassword();
                                                    }
                                                  }
                                                : loginController.isLoading ==
                                                        true
                                                    ? null
                                                    : () async {
                                                        if (loginController
                                                            .formKey
                                                            .currentState!
                                                            .validate()) {
                                                          Utility.hideKeyboard(
                                                              context);
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          final keys =
                                                              prefs.getKeys();
                                                          for (String key
                                                              in keys) {
                                                            var value =
                                                                prefs.get(key);
                                                            log('SharedPreferences $key: $value');
                                                          }
                                                          loginController
                                                              .login();
                                                        }
                                                      },
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: loginController.isForget,
                                        child: CustomTextIconButton(
                                          color: AppColors.yelloww,
                                          fontWeight: FontWeight.w600,
                                          txt: AppString.back,
                                          onpressed: () {
                                            loginController.isForget =
                                                !loginController.isForget;
                                            loginController.update();
                                          },
                                          icon: TablerIcons.chevrons_left,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            loginController.isForget ? 0 : 20,
                                      ),
                                      Visibility(
                                        visible: loginController.isSupported &&
                                            !loginController.isForget,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                 AppString.or,
                                                style: CommonText.style500S15
                                                    .copyWith(
                                                  color: AppColors.blackk,
                                                ),
                                              ),
                                              CustomTextIconButton(
                                                onpressed: loginController
                                                        .isLoading
                                                    ? null
                                                    : loginController
                                                        .authenticateWithBiometrics,
                                                icon: Icons.fingerprint,
                                                txt: AppString.loginWithFingerprint,
                                                color: AppColors.yelloww,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
