import 'package:flutter/material.dart';
import 'package:inexture/common_widget/app_string.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/asset.dart';
import '../../../common_widget/global_value.dart';
import '../../../common_widget/text.dart';
import '../../../utils/utility.dart';

class CustomLeaveWorkFromHomeCard extends StatelessWidget {
  const CustomLeaveWorkFromHomeCard({
    super.key,
    required this.myLeave,
    required this.todayLeave,
    required this.upcomingLeave,
    required this.wfh,
    required this.isMyLeave,
    required this.isTodayLeave,
    required this.isUpcoming,
    required this.isWFH,
    required this.onTapMyLeave,
    required this.onTapTodayLeave,
    required this.onTapUpcomingLeave,
    required this.onTapWorkFromHome,
  });

  final String myLeave;
  final String todayLeave;
  final String upcomingLeave;
  final String wfh;
  final bool isMyLeave;
  final bool isTodayLeave;
  final bool isUpcoming;
  final bool isWFH;
  final Function()? onTapMyLeave;
  final Function()? onTapTodayLeave;
  final Function()? onTapUpcomingLeave;
  final Function()? onTapWorkFromHome;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isAdminUser == false,
                  child: commonCard(
                    context: context,
                    image: AssetImg.myLeaveImg,
                    count: myLeave,
                    name:  AppString.myLeave,
                    color: AppColors.yelloww,
                    isLoading: isMyLeave,
                    onTap: onTapMyLeave,
                  ),
                ),
                commonCard(
                  context: context,
                  image: AssetImg.todayLeaveImg,
                  count: todayLeave,
                  name: AppString.leaveToday,
                  color: AppColors.greenn,
                  isLoading: isTodayLeave,
                  onTap: onTapTodayLeave,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                commonCard(
                    context: context,
                    image: AssetImg.upcomingLeaveImg,
                    count: upcomingLeave,
                    name: AppString.upcomingLeaves,
                    color: AppColors.redd,
                    isLoading: isUpcoming,
                    onTap: onTapUpcomingLeave),
                commonCard(
                  context: context,
                  image: AssetImg.wfhImg,
                  count: wfh,
                  name: AppString.wfhToday,
                  color: AppColors.blues,
                  isLoading: isWFH,
                  onTap: onTapWorkFromHome,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget commonCard({
    required BuildContext context,
    required String image,
    required String count,
    required String name,
    required Color color,
    required bool isLoading,
    Function()? onTap,
  }) {
    return Expanded(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Card(
              surfaceTintColor: color,
              margin: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Image(
                      image: AssetImage(image),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        count,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: CommonText.style500S20.copyWith(
                          color: color,
                        ),
                      ),
                      Text(
                        name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: CommonText.style500S15.copyWith(
                          color: AppColors.blackk,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Utility.shimmerLoading(
              margin: EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(10),
            ),
        ],
      ),
    );
  }
}