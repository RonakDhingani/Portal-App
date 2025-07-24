// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:inexture/common_widget/global_value.dart';

import '../../common_widget/app_colors.dart';

class IconContainer extends StatelessWidget {
  IconContainer({
    super.key,
    required this.isOnlyIconContainer,
    required this.img,
    this.onLongPress,
    this.onDoubleTap,
  });

  String img;
  bool isOnlyIconContainer;
  Function()? onLongPress;
  Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: users.contains(fireUserFullName) ? onDoubleTap : null,
      onLongPress: users.contains(fireUserFullName) ? onLongPress : null,
      child: isOnlyIconContainer
          ? Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Image(
                color: AppColors.blackk,
                image: AssetImage(img),
              ),
            )
          : Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Image(
                image: AssetImage(img),
              ),
            ),
    );
  }
}
