// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/utils/utility.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/profile_image.dart';
import '../../common_widget/text.dart';

class HomeProfileUiContainer extends StatelessWidget {
  HomeProfileUiContainer({
    super.key,
    required this.imgUrl,
    this.firstName,
    this.lastName,
    this.designation,
    this.isLoading,
    this.onTap,
  });

  String imgUrl;
  String? firstName;
  String? lastName;
  String? designation;
  bool? isLoading;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: ProfileImage(
                  userName:
                      "${firstName?[0].toUpperCase()}${lastName?[0].toUpperCase()}",
                  profileImage: imgUrl,
                  name: "$firstName $lastName",
                  radius: 25,
                  borderWidth: 1,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isLoading == true
                        ? Utility.shimmerLoading(
                            color: AppColors.greyy,
                            borderRadius: BorderRadius.circular(5),
                            height: 20.h,
                            width: 170.w,
                            margin: EdgeInsets.only(bottom: 1.h))
                        : Text(
                            '$firstName $lastName',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: CommonText.style500S20,
                          ),
                    isLoading == true
                        ? Utility.shimmerLoading(
                            color: AppColors.greyy,
                            borderRadius: BorderRadius.circular(5),
                            height: 15.h,
                            width: 150.w,
                          )
                        : Text(
                            '$designation',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: CommonText.style400S13.copyWith(
                              color: AppColors.whitee,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Spacer(
          flex: 2,
        )
      ],
    );
  }
}
