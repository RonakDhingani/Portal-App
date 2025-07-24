import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/controller/policies_controller.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../common_widget/app_colors.dart';
import '../common_widget/app_string.dart';
import '../common_widget/global_value.dart';
import '../common_widget/text.dart';
import '../utils/utility.dart';

class PoliciesScreen extends GetView<PoliciesController> {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.commonAppBar(
        context: context,
        title: AppString.policies,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utility.circleProcessIndicator();
        }
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: controller.policiesModel?.results?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 175,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              var policies = controller.policiesModel?.results?[index];
              return _policyCard(policies, index);
            },
          ),
        );
      }),
    );
  }

  Widget _policyCard(var policies, int index) {
    return GestureDetector(
      onTap: () {
        controller.openOtherAppFile(
          index: index,
          url: policies?.file ?? '',
        );
      },
      child: Obx(() {
        final isDownloading =
            controller.isFileDownloadingOrOpening[index] ?? false;
        final isDownloaded = controller.isFileAlreadyDownloaded[index] ?? false;
        final downloaded = controller.downloadedBytes[index] ?? 0;
        final total = controller.totalBytes[index] ?? 1;
        final progress =
            (total > 0) ? (downloaded / total).clamp(0.0, 1.0) : 0.0;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isDownloaded ? AppColors.yelloww : AppColors.greyy,
              width: isDownloaded ? 2 : 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SquareProgressIndicator(
            value: isDownloading ? progress : 0.0,
            borderRadius: 7,
            color: AppColors.yelloww,
            emptyStrokeColor: AppColors.transparent,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.redd.withOpacity(0.2),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: const Icon(
                              Icons.picture_as_pdf,
                              color: AppColors.redd,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${policies?.title ?? AppString.noTitle}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CommonText.style600S15.copyWith(
                              color: AppColors.blackk,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            Global.formatDate(policies?.createdAt ?? ''),
                            style: CommonText.style400S15.copyWith(
                              color: AppColors.blackk,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isDownloading)
                  Positioned(
                    top: 5.h,
                    right: 10.w,
                    child: FadeInLeft(
                      child: Text(
                        "${(progress * 100).toStringAsFixed(0)}%",
                        style: CommonText.style500S15.copyWith(
                          color: AppColors.blackk,
                        ),
                      ),
                    ),
                  )
                else if (isDownloaded)
                  Positioned(
                    top: 5.h,
                    right: 5.w,
                    child: Container(
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        color: AppColors.blackk,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.download_done,
                        color: AppColors.yelloww,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
