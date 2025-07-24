// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/buttons.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/utils/utility.dart';

import 'app_colors.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom({
    required this.controller,
    this.labelText,
    this.title,
    this.showSuffixIcon = false,
    this.showPrefixIcon = false,
    this.isShow = false,
    this.isForgetPass = false,
    this.colorSuffixIcon,
    this.colorPrefixIcon,
    this.textColor,
    this.fillColor,
    this.prefixIcon,
    this.focusNext,
    this.hasMultiLine = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.readOnly = false,
    this.isProgressActive = false,
    this.isBottomScrollPadding = false,
    this.enabled = true,
    this.inputFormatters,
    this.hintText,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.keyboardType = TextInputType.text,
    this.inputAction,
    this.validatorText,
    this.validator,
    this.onChanged,
    this.onPressed,
    this.onPressedForget,
    this.autofillHints,
    this.suffixIcon,
    this.onTap,
    this.isTitleHide = false,
    this.onFieldSubmitted,
    this.isOptional,
    this.isNeedHelp,
    this.onTapNeedHelp,
    super.key,
  });

  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNext;
  final String? labelText;
  final bool showSuffixIcon;
  final Widget? suffixIcon;
  final bool showPrefixIcon;
  final bool isShow;
  final Widget? prefixIcon;
  final Color? colorPrefixIcon;
  final Color? colorSuffixIcon;
  final Color? textColor;
  final Color? fillColor;
  final bool hasMultiLine;
  final bool readOnly;
  final bool enabled;
  final bool isProgressActive;
  final bool isBottomScrollPadding;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final String? validatorText;
  String? Function(String?)? validator;
  final String? title;
  final bool? isForgetPass;
  final bool? isTitleHide;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Function()? onPressed;
  final Function()? onPressedForget;
  List<String>? autofillHints;
  bool? isOptional;
  bool? isNeedHelp;
  Function()? onTapNeedHelp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitleHide == true
            ? Container()
            : Row(
                children: [
                  CommonText.requiredText(
                      title: title ?? '', isOptional: isOptional),
                  Spacer(),
                  if (isNeedHelp == true)
                    InkWell(
                      onTap: onTapNeedHelp,
                      child: Text(
                        AppString.suggestReason,
                        style: CommonText.style500S14
                            .copyWith(color: AppColors.blues),
                      ),
                    ),
                ],
              ),
        Container(
          margin: EdgeInsets.only(top: 5),
          // height: Device.get().isTablet ? 65 : 50,
          child: TextFormField(
            autofillHints: autofillHints,
            scrollPadding: isBottomScrollPadding
                ? const EdgeInsets.only(bottom: 290)
                : const EdgeInsets.only(bottom: 0),
            inputFormatters: inputFormatters ??
                [
                  FilteringTextInputFormatter.deny(
                      AppString.regExpBlocEmoji,
                  ),
                ],
            obscureText: !isShow,
            cursorColor: AppColors.yelloww,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            maxLines: maxLines ?? (hasMultiLine ? null : 1),
            minLines: minLines,
            readOnly: readOnly,
            maxLength: maxLength,
            textInputAction: inputAction,
            keyboardType: hasMultiLine ? TextInputType.multiline : keyboardType,
            onSaved: (value) {
              FocusScope.of(context).requestFocus(focusNext);
            },
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            style: CommonText.style400S14.copyWith(color: AppColors.blackk),
            validator: validator ??
                (val) {
                  if (val != null && val.isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
            onTap: onTap,
            enabled: enabled,
            decoration: InputDecoration(
              errorMaxLines: 3,
              hintMaxLines: 6,
              errorStyle:
                  CommonText.style400S14.copyWith(color: AppColors.redd),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.greyy,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.h,
              ),
              hintText: hintText,
              hintStyle: hintStyle ??
                  CommonText.style400S14.copyWith(
                    color: AppColors.greyyDark,
                  ),
              labelText: labelText,
              labelStyle: CommonText.style400S14.copyWith(
                color: AppColors.greyyDark,
              ),
              floatingLabelStyle: CommonText.style400S14.copyWith(
                color: AppColors.greyyDark,
              ),
              alignLabelWithHint: true,
              filled: true,
              fillColor: fillColor ?? AppColors.whitee,
              prefixIcon: showPrefixIcon
                  ? SizedBox(
                      child: Utility.cupertinoProcessIndicator(),
                      height: 40,
                      width: 40,
                    )
                  : const SizedBox(),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 16,
                minWidth: 16,
              ),
              suffixIcon: showSuffixIcon
                  ? isProgressActive
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CupertinoActivityIndicator(
                            color: AppColors.yelloww,
                          ),
                        )
                      : suffixIcon ??
                          IconButton(
                            color: AppColors.blackk,
                            onPressed: onPressed,
                            icon: isShow
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          )
                  : const SizedBox(),
              suffixIconConstraints: const BoxConstraints(
                minHeight: 56,
                minWidth: 16,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.redd,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.redd,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.greyy,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.yelloww,
                ),
              ),
            ),
          ),
        ),
        isForgetPass == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    onpressed: onPressedForget,
                    txt: AppString.forGotPassword,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
