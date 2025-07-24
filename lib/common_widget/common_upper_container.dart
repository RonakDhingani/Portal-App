import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inexture/common_widget/asset.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart';
import 'app_string.dart';
import 'global_value.dart';

class UpperContainer extends StatelessWidget {
  UpperContainer({
    super.key,
    this.firstChild,
    this.secondChild,
    this.flex,
    required this.isProfile,
    required this.isTodayBDay,
  });

  final Widget? firstChild;
  final Widget? secondChild;
  final int? flex;
  final bool isProfile;
  bool isTodayBDay = false;

  final WallpaperController wallpaperController =
      Get.put(WallpaperController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: wallpaperController.isImageBright.value
              ? Brightness.dark
              : Brightness.light,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Obx(
                    () => Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.yelloww,
                        image: wallpaperController.isRemoveWallPaper.value
                            ? DecorationImage(
                                image: wallpaperController
                                        .selectedImagePath.value
                                        .contains("assets/")
                                    ? AssetImage(wallpaperController
                                        .selectedImagePath.value)
                                    : FileImage(
                                        File(
                                          wallpaperController
                                              .selectedImagePath.value,
                                        ),
                                      ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          if (isTodayBDay == true)
                            Positioned(
                              top: 0,
                              child: Lottie.asset(
                                  width: MediaQuery.of(context).size.width * 1,
                                  "assets/lotties/badyCeleb.json",
                                  fit: BoxFit.cover,
                                  repeat: true),
                            ),
                          firstChild ?? SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                  if (isProfile)
                    Positioned(
                      top: 50,
                      right: 15,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            useSafeArea: true,
                            barrierDismissible: false,
                            builder: (_) {
                              return ValueListenableBuilder<ProImageItem>(
                                valueListenable:
                                    wallpaperController.imageValueListen,
                                builder: (context, value, child) {
                                  return AlertDialog(
                                    insetPadding: EdgeInsets.all(20),
                                    contentPadding: EdgeInsets.only(
                                      left: 10.w,
                                      top: 20.h,
                                      right: 10.w,
                                      bottom: 0.h,
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    icon: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            wallpaperController
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
                                      style: CommonText.style600S16.copyWith(
                                        color: AppColors.blackk,
                                      ),
                                    ),
                                    iconPadding:
                                        EdgeInsets.only(top: 5.h, right: 5.w),
                                    titlePadding: EdgeInsets.only(
                                        left: 15.w,
                                        top: 5.h,
                                        right: 5.w,
                                        bottom: 10.h),
                                    content: SizedBox(
                                      height: 300.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Text(
                                                  "${AppString.selectedColan} ${value.name} ${AppString.image}",
                                                  textAlign: TextAlign.center,
                                                  style: CommonText.style500S16
                                                      .copyWith(
                                                          color:
                                                              AppColors.blackk),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: GridView.builder(
                                              padding: EdgeInsets.all(10.sp),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 5.h,
                                                mainAxisExtent: 100,
                                                crossAxisSpacing: 5.w,
                                              ),
                                              itemCount:
                                                  proImageList.length + 1,
                                              itemBuilder: (context, index) {
                                                if (index ==
                                                    proImageList.length) {
                                                  return InkWell(
                                                    onTap: () async {
                                                      wallpaperController
                                                          .pickImageFromGallery();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors.greyy,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .add_photo_alternate,
                                                        color: AppColors.blackk,
                                                        size: 40.sp,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  final image =
                                                      proImageList[index];
                                                  final isSelected =
                                                      wallpaperController
                                                              .selectedImagePath
                                                              .value ==
                                                          image.path;
                                                  return InkWell(
                                                    onTap: () {
                                                      wallpaperController
                                                          .selectedImagePath
                                                          .value = image.path;
                                                      wallpaperController
                                                          .imageValueListen
                                                          .value = image;
                                                      log("Selected image id: ${image.id}");
                                                      log("Selected image name: ${image.name}");
                                                      log("Selected image path: ${image.path}");
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: isSelected
                                                                  ? AppColors
                                                                      .yelloww
                                                                  : Colors
                                                                      .transparent,
                                                              width: 3,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  image.path),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        if (isSelected)
                                                          Positioned(
                                                            right: 5.w,
                                                            top: 5.h,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .blackk,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: AppColors
                                                                    .yelloww,
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actionsPadding: EdgeInsets.zero,
                                    actions: [
                                      InkWell(
                                        onTap: () {
                                          if (wallpaperController
                                              .selectedImagePath.value
                                              .contains("assets/")) {
                                            wallpaperController
                                                .saveSelectedImage(
                                                    value.id, value.path);
                                          } else {
                                            wallpaperController
                                                .saveSelectedImage(
                                              "custom_image",
                                              wallpaperController
                                                  .selectedImagePath.value,
                                            );
                                          }
                                          Get.back();
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
                                                AppString.set,
                                                style: CommonText.style600S16,
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
                        child: Icon(
                          TablerIcons.brush,
                          color: AppColors.whitee,
                        ),
                      ),
                    ),
                  if (isProfile && Platform.isAndroid)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Text(
                        "v$appVersion",
                        style: CommonText.style500S12.copyWith(
                          color: AppColors.yellowWhite,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: secondChild,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WallpaperController extends GetxController {
  RxBool isRemoveWallPaper = false.obs;
  RxBool isImageBright = false.obs;
  RxString selectedImagePath = AssetImg.flowersImg.obs;
  ValueNotifier<ProImageItem> imageValueListen = ValueNotifier(
    ProImageItem(id: "1", name: "Flowers", path: AssetImg.flowersImg),
  );

  @override
  void onInit() {
    super.onInit();
    loadSelectedImage();
  }

  Future<void> saveSelectedImage(String imageId, String imagePath) async {
    isRemoveWallPaper.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('selectedBGImageId');
    await prefs.remove('selectedBGImagePath');
    await prefs.remove('isRemoveWallPaper');

    await prefs.setString('selectedBGImageId', imageId);
    await prefs.setString('selectedBGImagePath', imagePath);
    await prefs.setBool('isRemoveWallPaper', isRemoveWallPaper.value);

    selectedImagePath.value = imagePath;
    checkImageBrightness(File(imagePath));
  }

  Future<void> loadSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedImageId = prefs.getString('selectedBGImageId');
    String? savedImagePath = prefs.getString('selectedBGImagePath');
    isRemoveWallPaper.value = prefs.getBool('isRemoveWallPaper') ?? false;

    if (savedImageId != null && savedImagePath != null) {
      if (savedImageId == "custom_image") {
        if (File(savedImagePath).existsSync()) {
          selectedImagePath.value = savedImagePath;
          checkImageBrightness(File(savedImagePath));
        }
      } else {
        var selectedImage = proImageList.firstWhere(
          (image) => image.id == savedImageId,
        );
        imageValueListen.value = selectedImage;
        selectedImagePath.value = selectedImage.path;
        checkImageBrightness(File(savedImagePath));
      }
    } else {
      selectedImagePath.value = proImageList.first.path;
      checkImageBrightness(File(selectedImagePath.value));
    }
  }

  Future<void> pickImageFromGallery() async {
    final photosPermission = await Permission.photos.request();
    final storagePermission = await Permission.storage.request();

    if (photosPermission.isGranted || storagePermission.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final String? croppedImagePath =
            await cropImage(sourcePath: image.path);

        if (croppedImagePath != null) {
          selectedImagePath.value = croppedImagePath;
          checkImageBrightness(File(croppedImagePath));
        } else {
          print("Image cropping was cancelled or failed.");
        }
      } else {
        print("No image selected.");
      }
    } else if (photosPermission.isPermanentlyDenied ||
        storagePermission.isPermanentlyDenied) {
      print("Permission permanently denied. Opening app settings...");
      await openAppSettings();
    } else {
      print("Permission denied!");
    }
  }

  Future<String?> cropImage({required String sourcePath}) async {
    try {
      CroppedFile? croppedImg = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: AppColors.yelloww,
            toolbarWidgetColor: AppColors.whitee,
            backgroundColor: AppColors.whitee,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            hideBottomControls: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            title: 'Crop',
            hidesNavigationBar: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
        ],
      );

      if (croppedImg != null) {
        return croppedImg.path;
      } else {
        return sourcePath;
      }
    } catch (e) {
      print("Error cropping image: $e");
      return sourcePath;
    }
  }

  Future<void> checkImageBrightness(File imageFile) async {
    try {
      final image = Image.file(imageFile);
      final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        image.image,
        size: Size(200.w, 200.h),
      );

      final Color? dominantColor = palette.dominantColor?.color;
      if (dominantColor == null) {
        isImageBright.value = false;
        return;
      }

      final luminance = dominantColor.computeLuminance();
      isImageBright.value = luminance > 0.5;
    } catch (e) {
      print("Error analyzing image brightness: $e");
      isImageBright.value = false;
    }
  }
}
