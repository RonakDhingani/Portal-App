// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_string.dart';

class CommonText {
  static Widget normalIconText({
    required String title,
    required IconData icon,
    Color? color,
    Color? iconColor,
    MainAxisAlignment? mainAxisAlignment,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.yelloww,
            ),
          ),
          Text(
            title,
            style: style500S15.copyWith(
              color: color ?? AppColors.blackk,
            ),
          ),
        ],
      ),
    );
  }

  static RichText richText({
    required String firstTitle,
    required String secTitle,
    Color? color,
    int? maxLines,
    Color? firstColor,
    double? fontSize,
    double? fontSize2,
    FontWeight? fontWeight,
    FontWeight? fontWeight2,
    TextAlign? textAlign,
    TextStyle? style,
    TextStyle? style2,
  }) {
    return RichText(
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstTitle,
            style: style ?? CommonText.style600S15.copyWith(
              color: firstColor ?? AppColors.blackk,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
          TextSpan(
            text: secTitle,
            style: style2 ?? CommonText.style500S15.copyWith(
              color: color,
              fontSize: fontSize2,
              fontWeight: fontWeight2,
            ),
          ),
        ],
      ),
    );
  }

  static RichText dateRichText({
    required String firstDate,
    required String secDate,
    required Color dateColor,
  }) {
    return RichText(
      maxLines: 1,
      textAlign: TextAlign.start,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: AppString.dateColan,
            style: CommonText.style600S15.copyWith(
              color: AppColors.blackk,
            ),
          ),
          TextSpan(
            text: firstDate,
            style: CommonText.style500S15.copyWith(
              color: dateColor,
            ),
          ),
          TextSpan(
            text: ' ${AppString.toC} ',
            style: CommonText.style600S15.copyWith(
              color: AppColors.blackk,
            ),
          ),
          TextSpan(
            text: secDate,
            style: CommonText.style500S15.copyWith(
              color: dateColor,
            ),
          ),
        ],
      ),
    );
  }

  static RichText dateSmallRichText({
    required String firstDate,
    required String secDate,
    required Color dateColor,
  }) {
    return RichText(
      maxLines: 2,
      textAlign: TextAlign.start,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: AppString.dateColan,
            style: CommonText.style600S13.copyWith(
              color: AppColors.blues,
            ),
          ),
          TextSpan(
            text: firstDate,
            style: CommonText.style500S13.copyWith(
              color: dateColor,
            ),
          ),
          TextSpan(
            text: ' ${AppString.toC} ',
            style: CommonText.style700S13.copyWith(
              color: AppColors.blackk,
            ),
          ),
          TextSpan(
            text: secDate,
            style: CommonText.style500S13.copyWith(
              color: dateColor,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buttonText({
    required String title,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return Text(
      title,
      style: CommonText.style600S18.copyWith(
        color: color ?? AppColors.whitee,
      ),
    );
  }

  static Widget requiredText({
    required String title,
    bool? isOptional,
  }) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: style500S15.copyWith(
              color: AppColors.blackk,
            ),
          ),
          if(isOptional != true)
          TextSpan(
            text: "*",
            style: style500S15.copyWith(
              color: AppColors.redd,
            ),
          ),
        ],
      ),
    );
  }

  static Widget commonRow({
    String? title,
    String? titleValue,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Text(
              title ?? '',
              maxLines: 5,
              style: CommonText.style500S14.copyWith(
                color: AppColors.greyyDark.withOpacity(0.8),
              ),
            ),
          ),
          Flexible(
            child: Text(
              titleValue ?? '',
              maxLines: 3,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: CommonText.style500S14.copyWith(
                color: AppColors.blackk,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static TextStyle style400S10({required bool isBlack}) => GoogleFonts.poppins(
        textStyle: TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w400,
          fontSize: 10,
          color: isBlack ? AppColors.blackk : AppColors.whitee,
        ),
      );

  static TextStyle style400S13 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w400,
      fontSize: 13,
      color: AppColors.whitee,
    ),
  );

    static TextStyle style400S14 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style400S15 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style400S16 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style500S12 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style500S13 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 13,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style500S14 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style500S15 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style500S16 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.whitee,
    ),
  );
  static TextStyle style500S17 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: AppColors.whitee,
    ),
  );
  static TextStyle style500S18 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: AppColors.whitee,
    ),
  );
  static TextStyle style500S20 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style600S12 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style600S13 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style600S15 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style600S16 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style600S18 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: AppColors.whitee,
    ),
  );

  static TextStyle style700S13 = GoogleFonts.poppins(
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w700,
      fontSize: 13,
      color: AppColors.whitee,
    ),
  );
}
