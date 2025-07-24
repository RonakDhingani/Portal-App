// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/buttons.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';
import 'package:lottie/lottie.dart';

import '../../../common_widget/asset.dart';
import '../../../common_widget/common_app_bar.dart';
import '../../../common_widget/global_value.dart';
import '../../../controller/chat_with_ai_controller.dart';

class ChatWithAi extends GetView<ChatWithAiController> {
  ChatWithAi({super.key});

  final ChatWithAiController chatController = Get.put(ChatWithAiController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatWithAiController>(
      builder: (chatWithAiCtrl) {
        return GestureDetector(
          onTap: () {
            Utility.hideKeyboard(context);
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: chatWithAiCtrl.selectedImagePath.contains("assets/")
                    ? AssetImage(
                        chatWithAiCtrl.selectedImagePath,
                      ) as ImageProvider
                    : FileImage(
                        File(
                          chatWithAiCtrl.selectedImagePath,
                        ),
                      ),
                opacity: chatWithAiCtrl.sliderValue.value,
                fit: BoxFit.fitHeight,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0,
                sigmaY: 0,
              ),
              child: Scaffold(
                backgroundColor: AppColors.transparent,
                appBar: CommonAppBar.commonAppBar(
                  context: context,
                  title: AppString.chatWithInexaAI,
                  widget: Row(
                    children: [
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: AppColors.whitee,
                        ),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: "Wallpaper",
                            child: Text(AppString.wallpaper),
                            onTap: () {
                              showDialog(
                                context: context,
                                useSafeArea: true,
                                barrierDismissible: false,
                                builder: (_) {
                                  return ValueListenableBuilder<ImageItem>(
                                    valueListenable:
                                        chatWithAiCtrl.imageValueListen,
                                    builder: (context, value, child) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.all(20.sp),
                                        contentPadding: EdgeInsets.only(
                                          left: 10.w,
                                          top: 20.h,
                                          right: 10.w,
                                          bottom: 0.h,
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        icon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                chatWithAiCtrl
                                                    .loadSelectedImage();
                                                Get.back();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                size: 30.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        title: Text(
                                          AppString.wallpaper,
                                          style:
                                              CommonText.style600S16.copyWith(
                                            color: AppColors.blackk,
                                          ),
                                        ),
                                        iconPadding: EdgeInsets.only(
                                            top: 5.h, right: 5.w),
                                        titlePadding: EdgeInsets.only(
                                            left: 15.w,
                                            top: 5.h,
                                            right: 5.w,
                                            bottom: 10.h),
                                        content: SizedBox(
                                          height: 300.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      "Selected : ${value.name} Image",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: CommonText
                                                          .style500S12
                                                          .copyWith(
                                                              color: AppColors
                                                                  .blackk),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Flexible(
                                                child: GridView.builder(
                                                  padding: EdgeInsets.all(10),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: 5.h,
                                                    mainAxisExtent: 100,
                                                    crossAxisSpacing: 5.w,
                                                  ),
                                                  itemCount:
                                                      imageList.length + 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index ==
                                                        imageList.length) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          await chatWithAiCtrl
                                                              .pickImageFromGallery();
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                AppColors.greyy,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .add_photo_alternate,
                                                            color: AppColors
                                                                .blackk,
                                                            size: 40,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      var image =
                                                          imageList[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          chatWithAiCtrl
                                                                  .selectedImagePath =
                                                              image.path;
                                                          chatWithAiCtrl
                                                              .imageValueListen
                                                              .value = image;
                                                          chatWithAiCtrl
                                                              .update();
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                image.path,
                                                              ),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                              ValueListenableBuilder<double>(
                                                  valueListenable:
                                                      chatWithAiCtrl
                                                          .sliderValue,
                                                  builder: (context,
                                                      sliderValue, child) {
                                                    return Stack(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              AppString.opacity,
                                                              style: CommonText
                                                                  .style400S15
                                                                  .copyWith(
                                                                color: AppColors
                                                                    .greyyDark,
                                                              ),
                                                            ),
                                                            Slider(
                                                              min: 0.0,
                                                              max: 1.0,
                                                              divisions: 100,
                                                              activeColor:
                                                                  AppColors
                                                                      .yelloww,
                                                              inactiveColor:
                                                                  AppColors
                                                                      .yelloww
                                                                      .withOpacity(
                                                                          0.3),
                                                              value:
                                                                  sliderValue,
                                                              onChanged:
                                                                  (value) {
                                                                chatWithAiCtrl
                                                                    .sliderValue
                                                                    .value = value;
                                                                chatWithAiCtrl
                                                                    .update();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Positioned(
                                                          right: 15,
                                                          bottom: 0,
                                                          child: Text(
                                                            "$sliderValue",
                                                            style: CommonText
                                                                .style500S15
                                                                .copyWith(
                                                              color: AppColors
                                                                  .greyyDark,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                        actionsPadding: EdgeInsets.zero,
                                        actions: [
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              if (chatWithAiCtrl
                                                  .selectedImagePath
                                                  .contains("assets/")) {
                                                chatWithAiCtrl
                                                    .saveSelectedImage(
                                                        imageId: value.id,
                                                        sliderValue:
                                                            chatWithAiCtrl
                                                                .sliderValue
                                                                .value,
                                                        imagePath: value.path);
                                              } else {
                                                chatWithAiCtrl
                                                    .saveSelectedImage(
                                                  imageId: "custom_image_chat",
                                                  sliderValue: chatWithAiCtrl
                                                      .sliderValue.value,
                                                  imagePath: chatWithAiCtrl
                                                      .selectedImagePath,
                                                );
                                              }
                                              chatWithAiCtrl.update();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              color: AppColors.yelloww,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Set",
                                                    style:
                                                        CommonText.style600S16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                body: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                              controller: chatWithAiCtrl.scrollController,
                              itemCount: chatWithAiCtrl.messages.length +
                                  (chatWithAiCtrl.isTyping ? 1 : 0),
                              itemBuilder: (_, int index) {
                                if (chatWithAiCtrl.isTyping &&
                                    index == chatWithAiCtrl.messages.length) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50.w,
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.whitee,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(0.0),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Lottie.asset(
                                          AssetLotties.typingLottie,
                                          repeat: true,
                                          decoder: LottieComposition.decodeGZip,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                var message = chatWithAiCtrl.messages[index];
                                return message;
                              },
                            ),
                          ),
                          Visibility(
                            visible: !chatWithAiCtrl.isErrorLimitReach,
                            replacement: Container(
                              color: AppColors.whitee,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextIconButton(
                                    color: AppColors.yelloww,
                                    fontWeight: FontWeight.w600,
                                    txt: AppString.back,
                                    onpressed: () {
                                      Get.back();
                                    },
                                    icon: TablerIcons.chevrons_left,
                                  ),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildTextComposer(context),
                                  ),
                                  SizedBox(width: 8.0),
                                  Container(
                                    height: 43.w,
                                    width: 43.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.yelloww,
                                      shape: BoxShape.circle,
                                    ),
                                    child: chatWithAiCtrl.isTyping
                                        ? Utility.circleProcessIndicator(
                                            color: AppColors.whitee)
                                        : IconButton(
                                            icon: Icon(
                                              Icons.send,
                                              color: AppColors.whitee,
                                            ),
                                            onPressed: () => chatController
                                                .handleSubmitted(chatController
                                                    .txtController.text),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (chatController.speechToText.isListening)
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 150.h,
                              width: 150.w,
                              child: Lottie.asset(
                                AssetLotties.siriAnimationLottie,
                                repeat: true,
                                decoder: LottieComposition.decodeGZip,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextComposer(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 5,
      textInputAction: TextInputAction.newline,
      textAlignVertical: TextAlignVertical.center,
      controller: chatController.txtController,
      style: CommonText.style500S15.copyWith(
        color: AppColors.blackk,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whitee,
        hintText: AppString.messageInexa,
        hintStyle: CommonText.style500S15.copyWith(
          color: AppColors.greyyDark,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: chatController.speechToText.isListening
            ? IntrinsicWidth(
                child: GestureDetector(
                  onTap: chatController.stopListening,
                  child: Icon(
                    Icons.stop_circle_outlined,
                    color: AppColors.redd,
                  ),
                ),
              )
            : null,
        suffixIcon: IconButton(
          onPressed: chatController.speechToText.isNotListening
              ? chatController.startListening
              : null,
          icon: Icon(
            chatController.speechToText.isNotListening
                ? Icons.mic_off_outlined
                : Icons.mic,
            color: chatController.speechToText.isNotListening
                ? AppColors.greyyDark
                : AppColors.blackk,
          ),
        ),
      ),
    );
  }
}
