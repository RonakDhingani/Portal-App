import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/app_string.dart';
import '../../common_widget/common_app_bar.dart';
import '../../common_widget/global_value.dart';
import '../../common_widget/text.dart';
import '../../routes/app_pages.dart';

class PendingEod extends StatelessWidget {
  const PendingEod({super.key, required this.pendingEOD});

  final List<String> pendingEOD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.commonAppBar(
        context: context,
        title: AppString.pendingEod,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: pendingEOD.length,
          itemBuilder: (context, index) {
            var eod = pendingEOD[index];
            return Card(
              child: ListTile(
                onTap: () {
                  Get.toNamed(Routes.addWorkLog, arguments: {
                    'date': eod.toString(),
                    'isFromHome': true
                  })?.then(
                    (value) {
                      if (value != null) {
                        Get.back();
                      }
                    },
                  );
                },
                title: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: AppString.yourWorkLogFor,
                        style: CommonText.style500S15.copyWith(
                          color: AppColors.blackk,
                        ),
                      ),
                      TextSpan(
                        text: Global.formatDate(eod.toString().split(' ')[0]),
                        style: CommonText.style500S14.copyWith(
                          color: AppColors.redd,
                        ),
                      ),
                      TextSpan(
                        text: AppString.isPending,
                        style: CommonText.style500S15.copyWith(
                          color: AppColors.blackk,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  AppString.pleaseCompleteItAtYourEarliestConvenience,
                  style: CommonText.style400S14.copyWith(
                    color: AppColors.greyyDark,
                  ),
                ),
                leading: Icon(
                  TablerIcons.exclamation_circle_filled,
                  color: AppColors.redd,
                ),
                trailing: Icon(TablerIcons.share_3),
              ),
            );
          },
        ),
      ),
    );
  }
}
