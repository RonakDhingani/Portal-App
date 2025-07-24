import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/text.dart';

import 'app_colors.dart';

class CommonAppBar {
  static PreferredSizeWidget? commonAppBar({
    required BuildContext context,
    double? height,
    double? width,
    Color? color,
    required String title,
    bool isButtonHide = false,
    Widget? widget,
    Function()? onPressed,
  }) {
    return AppBar(
      backgroundColor: color ?? AppColors.yelloww,
      elevation: 0,
      actions: [widget ?? SizedBox()],
      centerTitle: false,
      titleSpacing: isButtonHide ? 20 : 0,
      leading: isButtonHide
          ? null
          : IconButton(
              highlightColor: AppColors.transparent,
              onPressed: onPressed ??
                  () {
                    Get.back();
                  },
              icon: Icon(
                CupertinoIcons.back,
                color: AppColors.whitee,
                // size: 25,
              ),
            ),
      title: Text(
        title,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: CommonText.style500S18,
      ),
      automaticallyImplyLeading: false,
    );
  }
}
