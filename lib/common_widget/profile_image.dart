import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';

import 'app_colors.dart';
import 'app_string.dart';
import 'common_app_bar.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.userName,
    required this.name,
    required this.profileImage,
    this.radius = 35,
    this.borderWidth,
    this.borderColor,
    this.isFromRequest,
    this.isDisable,
  });

 final String userName;
 final String name;
 final String profileImage;
 final double radius;
 final double? borderWidth;
 final Color? borderColor;
 final bool? isFromRequest;
 final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (profileImage != 'null' && profileImage.isNotEmpty) {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) => ProfileView(
                profileImage: profileImage,
                userName: name,
              ),
            ),
          );
        // }
      },
      child: (profileImage == 'null' || profileImage.isEmpty)
          ? CircleAvatar(
              radius: radius,
              backgroundColor: AppColors.whitee,
              child: Center(
                child: isFromRequest == true
                    ? Container(
                        padding: EdgeInsets.all(1.3),
                        decoration: BoxDecoration(
                            color: AppColors.yellowWhite,
                            shape: BoxShape.circle),
                        child: Text(
                          userName,
                          style: CommonText.style600S16.copyWith(
                            color: AppColors.yelloww,
                            fontSize: 10.sp,
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(radius * 0.4),
                        decoration: BoxDecoration(
                            color: isDisable == true
                                ? AppColors.greyyDark.withOpacity(0.3)
                                : AppColors.yelloww.withOpacity(0.3),
                            shape: BoxShape.circle),
                        child: Text(
                          userName,
                          style: CommonText.style600S16.copyWith(
                            color: isDisable == true
                                ? AppColors.greyyDark
                                : AppColors.yelloww,
                            fontSize: radius * 0.6,
                          ),
                        ),
                      ),
              ),
            )
          : Hero(
        tag: UniqueKey(),
        child: CachedNetworkImage(
          cacheManager: DefaultCacheManager(),
          imageUrl: profileImage,
          progressIndicatorBuilder: (context, url, progress) => CircleAvatar(
            radius: radius,
            child: Utility.shimmerLoading(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          imageBuilder: (context, imageProvider) {
            Widget avatar = CircleAvatar(
              backgroundImage: imageProvider,
              radius: radius,
            );

            if (isDisable == true) {
              avatar = ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [AppColors.greyyDark, AppColors.greyyDark],
                ).createShader(bounds),
                blendMode: BlendMode.saturation,
                child: avatar,
              );
            }

            return ClipOval(child: avatar);
          },
          errorWidget: (context, url, error) {
            return const Icon(Icons.error_outline);
          },
        ),
      )
    );
  }
}

class ProfileView extends StatefulWidget {
  final String profileImage;
  final String? userName;

  const ProfileView({super.key, required this.profileImage, this.userName});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  double verticalDrag = 0;
  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;
  Offset? _doubleTapPosition;

  double _calculateOpacity() {
    return (1.0 - (verticalDrag.abs() / 200)).clamp(0.1, 1.0);
  }

  void _handleDoubleTap() {
    setState(() {
      if (_currentScale > 1.0) {
        // Reset to original scale
        _currentScale = 1.0;
        _transformationController.value = Matrix4.identity();
      } else {
        // Zoom in
        _currentScale = 2.0;
        if (_doubleTapPosition != null) {
          final position = _doubleTapPosition!;
          final matrix = Matrix4.identity()
            ..translate(-position.dx * (_currentScale - 1.0), -position.dy * (_currentScale - 1.0))
            ..scale(_currentScale);
          _transformationController.value = matrix;
        }
      }
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          verticalDrag += details.primaryDelta ?? 0;
        });
      },
      onVerticalDragEnd: (details) {
        if (verticalDrag.abs() > 100) {
          Get.back();
        } else {
          setState(() {
            verticalDrag = 0; // Reset
          });
        }
      },
      onDoubleTapDown: (widget.profileImage != 'null' && widget.profileImage.isNotEmpty) ? (details) {
        _doubleTapPosition = details.localPosition;
      } : (d) {},
      onDoubleTap: _handleDoubleTap,
      child: Scaffold(
        backgroundColor: AppColors.blackk.withOpacity(_calculateOpacity()),
        appBar: CommonAppBar.commonAppBar(
          context: context,
          isButtonHide: false,
          color: AppColors.blackk.withOpacity(_calculateOpacity()),
          title: widget.userName ?? '',
        ),
        body: Center(
          child: Transform.translate(
            offset: Offset(0, verticalDrag),
            child: Hero(
              tag: UniqueKey(),
              child: InteractiveViewer(
                panEnabled: true,
                scaleEnabled: true,
                minScale: 1.0,
                maxScale: 5.0,
                transformationController: _transformationController,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    cacheManager: DefaultCacheManager(),
                    imageUrl: widget.profileImage,
                    placeholder: (context, url) =>
                        Utility.circleProcessIndicator(),
                    errorWidget: (context, url, error) => Center(
                      child: Text(
                        AppString.noProfilePhoto,
                        style: CommonText.style500S15,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

