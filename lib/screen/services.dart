// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/global_value.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:inexture/controller/services_controller.dart';

class ServicesScreen extends GetView<ServicesController> {
  ServicesScreen({super.key});

  @override
  ServicesController controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesController>(
      builder: (servicesController) {
        return Scaffold(
          backgroundColor: AppColors.greyy.withOpacity(0.1),
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.services,
            isButtonHide: true,
          ),
          body: Visibility(
            visible: isAdminUser == false,
            replacement:  Center(
              child: Text(
                AppString.servicesAreComingSoon,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: CommonText.style500S15.copyWith(
                  color: AppColors.blackk,
                ),
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: servicesController.services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 150.h,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      servicesController.navigateToService(
                          servicesController.services[index].name);
                    },
                    child: Card(
                      surfaceTintColor: AppColors.whitee,
                      color: AppColors.whitee,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.blues.withOpacity(0.1),
                            ),
                            child: Icon(servicesController.services[index].icon),
                          ),
                          SizedBox(height: 10),
                          Text(
                            servicesController.services[index].name,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: CommonText.style500S15.copyWith(
                              color: AppColors.blackk,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
