// ignore_for_file: must_be_immutable, dead_code, prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';

import 'app_colors.dart';
import 'app_string.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton(
      {super.key, this.onpressed, this.txt, this.color, this.fontWeight});

  Function()? onpressed;
  String? txt;
  Color? color;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            // backgroundColor: WidgetStatePropertyAll(color?.withOpacity(0.1)),
            alignment: Alignment.bottomCenter,
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(),
            ),
          ),
          onPressed: onpressed,
          child: Text(
            maxLines: 1,
            textAlign: TextAlign.center,
            txt ?? '',
            style: CommonText.style500S15.copyWith(
              color: color ?? AppColors.blackk,
              // fontWeight: FontWeight.w800
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextIconButton extends StatelessWidget {
  CustomTextIconButton({
    super.key,
    this.onpressed,
    this.txt,
    this.color,
    this.fontWeight,
    this.icon,
    this.isBgColor = false,
  });

  Function()? onpressed;
  String? txt;
  Color? color;
  FontWeight? fontWeight;
  IconData? icon;
  bool? isBgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(isBgColor == true
                ? AppColors.yelloww.withOpacity(0.2)
                : AppColors.transparent),
            alignment: Alignment.bottomCenter,
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          onPressed: onpressed,
          icon: Icon(
            icon,
            color: color ?? AppColors.yelloww,
          ),
          label: Text(
            txt ?? '',
            style: CommonText.style400S16.copyWith(
              color: color ?? AppColors.blackk,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    this.onpressed,
    this.txt,
    this.isEnable = false,
    this.isLoading = false,
    this.isShowAnimateText = false,
    this.clr,
  });

  Function()? onpressed;
  String? txt;
  bool isEnable;
  bool isLoading;
  bool isShowAnimateText;
  Color? clr;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(100, 50)),
          backgroundColor: WidgetStatePropertyAll(isEnable
              ? clr != null
                  ? AppColors.redd
                  : AppColors.yelloww
              : AppColors.greyy),
          side: WidgetStatePropertyAll(
            BorderSide(
                color: isEnable
                    ? clr != null
                        ? AppColors.redd
                        : AppColors.yelloww
                    : AppColors.greyy),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        onPressed: isEnable ? onpressed : null,
        child: isLoading
            ? isShowAnimateText
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText(
                            AppString.itsOneTimeSignInProcess,
                            textAlign: TextAlign.start,
                            textStyle: CommonText.style500S15.copyWith(
                              color: AppColors.whitee,
                            ),
                            rotateOut: false,
                            duration: Duration(milliseconds: 300),
                          ),
                          RotateAnimatedText(
                            AppString.holdTight,
                            textAlign: TextAlign.start,
                            textStyle: CommonText.style500S15.copyWith(
                              color: AppColors.whitee,
                            ),
                            rotateOut: false,
                            duration: Duration(milliseconds: 300),
                          ),
                          RotateAnimatedText(
                            AppString.checkingDetails,
                            textAlign: TextAlign.start,
                            textStyle: CommonText.style500S15.copyWith(
                              color: AppColors.whitee,
                            ),
                            rotateOut: false,
                            duration: Duration(milliseconds: 300),
                          ),
                          RotateAnimatedText(
                            AppString.almostReady,
                            textAlign: TextAlign.start,
                            textStyle: CommonText.style500S15.copyWith(
                              color: AppColors.whitee,
                            ),
                            rotateOut: false,
                            duration: Duration(milliseconds: 300),
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                      Spacer(),
                      Utility.circleProcessIndicator(color: AppColors.whitee),
                    ],
                  )
                : Utility.circleProcessIndicator(color: AppColors.whitee)
            : Text(
                txt ?? '',
                style: CommonText.style600S18,
              ),
      ),
    );
  }
}

class CustomOutLineButton extends StatelessWidget {
  CustomOutLineButton({
    super.key,
    this.onpressed,
    this.txt,
    this.isEnable = false,
    this.isLoading = false,
    this.radius,
  });

  Function()? onpressed;
  String? txt;
  bool isEnable;
  bool isLoading;
  double? radius;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(100, 50)),
          side: WidgetStatePropertyAll(
            BorderSide(color: isEnable ? AppColors.yelloww : AppColors.greyy),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 5.r),
            ),
          ),
        ),
        onPressed: onpressed,
        child: isLoading
            ? Utility.circleProcessIndicator()
            : CommonText.buttonText(title: txt ?? '', color: AppColors.yelloww),
      ),
    );
  }
}
