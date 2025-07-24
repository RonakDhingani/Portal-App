// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/text.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/profile_image.dart';

class ProfileUi extends StatelessWidget {
  ProfileUi({
    super.key,
    required this.imgUrl,
    this.firstName,
    this.lastName,
    this.designation,
  });

  String imgUrl;
  String? firstName;
  String? lastName;
  String? designation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 44.h,
            left: 9.w,
            child: Text(
              AppString.profile,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: CommonText.style500S18,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 15, bottom: 20),
                  child: ProfileImage(
                    userName:
                        "${firstName?[0].toUpperCase()}${lastName?[0].toUpperCase()}",
                    profileImage: imgUrl,
                    name: "$firstName $lastName",
                    radius: 41.r,
                    borderWidth: 1.w,
                  ),
                ),
                Text(
                  '$firstName $lastName',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: CommonText.style500S20.copyWith(
                    color: AppColors.whitee,
                  ),
                ),
                Text(
                  '$designation',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: CommonText.style400S13.copyWith(
                    color: AppColors.whitee,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
