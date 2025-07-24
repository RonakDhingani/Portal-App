import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../common_widget/app_colors.dart';
import '../../../../common_widget/app_string.dart';
import '../../../../common_widget/asset.dart';
import '../../../../common_widget/profile_image.dart';
import '../../../../common_widget/text.dart';

class GameZoneListTile extends StatelessWidget {
  const GameZoneListTile({
    super.key,
    required this.proImg,
    required this.useName,
    required this.bookingDate,
    required this.onGoingTitle,
    required this.useNameForImg,
    required this.areaOrGameName,
    required this.isDisable,
    required this.isOnGoing,
    required this.isShowStackImg,
    required this.employees,
    required this.onTap,
  });

  final String useNameForImg;
  final String useName;
  final String areaOrGameName;
  final String proImg;
  final String bookingDate;
  final String onGoingTitle;
  final bool isDisable;
  final bool isOnGoing;
  final List<dynamic> employees;
  final bool isShowStackImg;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: ListTile(
        onTap: onTap,
        leading: ProfileImage(
          userName: useNameForImg,
          profileImage: proImg,
          name: useName,
          radius: 25,
          isDisable: isDisable,
        ),
        title:  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              useName,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: CommonText.style500S15.copyWith(
                color: isDisable
                    ? AppColors.greyyDark.withValues(alpha: 0.6)
                    : AppColors.blackk,
              ),
            ),
            if (isOnGoing)
              Container(
                margin: EdgeInsets.only(left: 2.w, top: 2.h),
                decoration: BoxDecoration(
                    color: AppColors.greenn2.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(5.r)
                ),
                child: Lottie.asset(
                  AssetLotties.waitingLottie,
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                  repeat: true,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.richText(
              maxLines: 2,
              firstTitle: AppString.bookingDateColan,
              secTitle: bookingDate,
              color: isDisable
                  ? AppColors.greyyDark.withValues(alpha: 0.6)
                  : AppColors.blackk,
              fontSize: 13,
              fontSize2: 13,
              firstColor: isDisable
                  ? AppColors.greyyDark.withValues(alpha: 0.6)
                  : AppColors.blues,
              // maxLines: ,
            ),
            if (isOnGoing)
              IntrinsicWidth(
                child: Row(
                  children: [
                    Text(
                      onGoingTitle,
                      style: CommonText.style600S13
                          .copyWith(color: AppColors.greenn2),
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          '...',
                          textStyle: CommonText.style600S13.copyWith(
                              color: AppColors.greenn2, letterSpacing: 1.7),
                          speed: Duration(
                            milliseconds: 500,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                    ),
                  ],
                ),
              )
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isShowStackImg,
              child: FlutterImageStack.widgets(
                totalCount: employees.length,
                itemRadius: 30,
                itemCount: 3,
                itemBorderWidth: 2,
                children: employees.map((e) {
                  return ProfileImage(
                    userName:
                        '${e.firstName?[0].toUpperCase()}${e.lastName?[0].toUpperCase()}',
                    profileImage: e.userImage ?? '',
                    radius: 11.r,
                    isDisable: isDisable,
                    name: "${e.firstName} ${e.lastName}",
                  );
                }).toList(),
              ),
            ),
            Text(
              areaOrGameName,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: CommonText.style500S12.copyWith(
                color: !isDisable
                    ? AppColors.blackk
                    : AppColors.greyyDark.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
