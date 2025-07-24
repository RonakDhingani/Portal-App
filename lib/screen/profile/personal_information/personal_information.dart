// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_colors.dart';
import 'package:inexture/common_widget/app_string.dart';
import 'package:inexture/common_widget/common_app_bar.dart';
import 'package:inexture/common_widget/common_info_ui.dart';

import '../../../controller/main_home_controller.dart';
import '../../../controller/personal_information_controller.dart';

class PersonalInformationScreen extends GetView<PersonalInformationController> {
  PersonalInformationScreen({super.key});

  @override
  PersonalInformationController controller =
      Get.put(PersonalInformationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInformationController>(
      builder: (personalInformationController) {
        var userDetails =
            Get.find<MainHomeController>().userProfileDetailsModel?.data;
        return Scaffold(
          backgroundColor: AppColors.whiteeDark,
          appBar: CommonAppBar.commonAppBar(
            context: context,
            title: AppString.personalInformation,
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25 - 5,
                color: AppColors.yelloww,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      CommonExpansionPanelList(
                        isPersonalInformation: true,
                        expansionCallback: (panelIndex, isExpanded) {
                          personalInformationController.isExpandedBasic =
                              !isExpanded;
                          personalInformationController.update();
                        },
                        titleInfo: AppString.basicInformation,
                        isExpand: personalInformationController.isExpandedBasic,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CommonPersonalUiWidget.commonBasicInfoUI(
                            employeeId: userDetails?.userdetails?.code,
                            userName: userDetails?.username,
                            experience: userDetails
                                ?.userdetails?.experience?.total?.year
                                .toString(),
                            joinedDate: userDetails?.userdetails?.joiningDate,
                            confirmedDate:
                                userDetails?.userdetails?.confirmationDate,
                            contact: userDetails?.phoneNumber,
                            email: userDetails?.email,
                          ),
                        ),
                      ),
                      userDetails?.experiences?.isNotEmpty == true
                          ? CommonExpansionPanelList(
                              isPersonalInformation: true,
                              expansionCallback: (panelIndex, isExpanded) {
                                personalInformationController.isExpandedExp =
                                    !isExpanded;
                                personalInformationController.update();
                              },
                              titleInfo: AppString.experience,
                              isExpand:
                                  personalInformationController.isExpandedExp,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child:
                                    CommonPersonalUiWidget.commonExperienceUI(
                                  companyName: userDetails?.experiences
                                      ?.map((e) => e.company)
                                      .join(', '),
                                  designation: userDetails?.experiences
                                      ?.map((e) => e.designation)
                                      .join(', '),
                                  joinedDate: userDetails?.experiences
                                      ?.map((e) => e.joinedDate)
                                      .join(', '),
                                  releasedDate: userDetails?.experiences
                                      ?.map((e) => e.releasedDate)
                                      .join(', '),
                                ),
                              ),
                            )
                          : Container(),
                      userDetails?.educations?.isNotEmpty == true
                          ? CommonExpansionPanelList(
                              isPersonalInformation: true,
                              expansionCallback: (panelIndex, isExpanded) {
                                personalInformationController.isExpandedEdu =
                                    !isExpanded;
                                personalInformationController.update();
                              },
                              titleInfo: AppString.education,
                              isExpand:
                                  personalInformationController.isExpandedEdu,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: CommonPersonalUiWidget.commonEducationUI(
                                  degree: userDetails?.educations
                                      ?.map((e) => e.qualification)
                                      .join(', '),
                                  board: userDetails?.educations
                                      ?.map((e) => e.universityBoard)
                                      .join(', '),
                                  year: userDetails?.educations
                                      ?.map((e) => e.passingYear)
                                      .join(', '),
                                  grade: userDetails?.educations
                                      ?.map((e) => e.grade)
                                      .join(', '),
                                ),
                              ),
                            )
                          : Container(),
                      userDetails?.userdetails?.technologyDetails?.isNotEmpty ==
                              true
                          ? CommonExpansionPanelList(
                              isPersonalInformation: true,
                              expansionCallback: (panelIndex, isExpanded) {
                                personalInformationController.isExpandedSkill =
                                    !isExpanded;
                                personalInformationController.update();
                              },
                              titleInfo: AppString.skills,
                              isExpand:
                                  personalInformationController.isExpandedSkill,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: CommonPersonalUiWidget.commonSkillsUI(
                                  technologyDetails: userDetails
                                          ?.userdetails?.technologyDetails ??
                                      [],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
