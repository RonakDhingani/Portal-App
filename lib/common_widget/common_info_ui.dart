// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../model/user_personal_details_model.dart';
import 'app_colors.dart';
import 'app_string.dart';
import 'text.dart';

class CommonPersonalUiWidget {
  static Widget commonBasicInfoUI({
    String? employeeId,
    String? userName,
    String? experience,
    String? joinedDate,
    String? confirmedDate,
    String? contact,
    String? email,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CommonText.commonRow(
          title: AppString.employeeId,
          titleValue: employeeId ?? '',
        ),
        CommonText.commonRow(
          title: AppString.userName,
          titleValue: userName ?? '',
        ),
        CommonText.commonRow(
          title: AppString.experience,
          titleValue: experience == '0' ? 'NA' : experience,
        ),
        CommonText.commonRow(
          title: AppString.joinedDate,
          titleValue: joinedDate ?? '',
        ),
        CommonText.commonRow(
          title: AppString.confirmedDate,
          titleValue: confirmedDate ?? '',
        ),
        CommonText.commonRow(
          title: AppString.contact,
          titleValue: contact ?? '',
        ),
        CommonText.commonRow(
          title: AppString.email,
          titleValue: email ?? '',
        ),
      ],
    );
  }

  static Widget commonRequestInfoUI({
    String? returnDate,
    String? requestedDate,
    String? startDate,
    String? endDate,
    required String dayType,
    String? halfDayTime,
    String? requestedLeaves,
    String? phone,
    bool? isAdhocLeave,
    bool? isAvailableOnPhone,
    bool? isAvailableOnCity,
    bool? isWorkFromHome,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CommonText.commonRow(
          title: AppString.duration,
          titleValue: '$requestedLeaves',
        ),
        CommonText.commonRow(
          title: AppString.dayType,
          titleValue: dayType.toUpperCase().substring(0, 1) +
              dayType.toLowerCase().substring(1),
        ),
        CommonText.commonRow(
          title: AppString.adhocLeave,
          titleValue: isAdhocLeave == true ? AppString.yes : AppString.no,
        ),
        Visibility(
          visible: dayType == AppString.half ? true : false,
          child: CommonText.commonRow(
            title: AppString.halfDayTime,
            titleValue: halfDayTime,
          ),
        ),
        Visibility(
          visible: isWorkFromHome ?? true,
          child: Column(
            children: [
              CommonText.commonRow(
                title: AppString.availableOnPhone,
                titleValue: isAvailableOnPhone == true ? AppString.yes : AppString.no,
              ),
              Visibility(
                visible: isAvailableOnPhone == true,
                child: CommonText.commonRow(
                  title: AppString.emergencyContact,
                  titleValue: (phone?.isEmpty == true || phone == null)
                      ? AppString.notAvailable
                      : phone,
                ),
              ),
              CommonText.commonRow(
                title: AppString.availableOnCity,
                titleValue: isAvailableOnCity == true ? AppString.yes : AppString.no,
              ),
            ],
          ),
        ),
        CommonText.commonRow(
          title: AppString.requestedDate,
          titleValue: '$requestedDate',
        ),
        CommonText.commonRow(
          title: AppString.startDate,
          titleValue: '$startDate',
        ),
        CommonText.commonRow(
          title: AppString.endDate,
          titleValue: '$endDate',
        ),
        CommonText.commonRow(
          title: AppString.returnDate,
          titleValue: '$returnDate',
        ),
      ],
    );
  }

  static Widget commonExperienceUI({
    String? companyName,
    String? designation,
    String? joinedDate,
    String? releasedDate,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CommonText.commonRow(
          title: AppString.companyName,
          titleValue: companyName ?? '',
        ),
        CommonText.commonRow(
          title: AppString.designation,
          titleValue: designation ?? '',
        ),
        CommonText.commonRow(
          title: AppString.joinedDate,
          titleValue: joinedDate ?? '',
        ),
        CommonText.commonRow(
          title: AppString.releasedDate,
          titleValue: releasedDate ?? '',
        ),
      ],
    );
  }

  static Widget commonEducationUI({
    String? degree,
    String? board,
    String? year,
    String? grade,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CommonText.commonRow(
          title: AppString.degree,
          titleValue: degree ?? '',
        ),
        CommonText.commonRow(
          title: AppString.board,
          titleValue: board ?? '',
        ),
        CommonText.commonRow(
          title: AppString.year,
          titleValue: year ?? '',
        ),
        CommonText.commonRow(
          title: AppString.grade,
          titleValue: grade ?? '',
        ),
      ],
    );
  }

  static Widget commonSkillsUI({
    required List<TechnologyDetails> technologyDetails,
  }) {
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.height * 0.3 + 10,
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 50,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: technologyDetails.length,
        itemBuilder: (context, index) {
          var skills = technologyDetails[index];
          return ChoiceChip(
            label: Animate(
              effects: [
                ShimmerEffect(
                  color: AppColors.yelloww,
                  duration: Duration(seconds: 5),
                ),
              ],
              onComplete: (controller) {
                controller.repeat();
              },
              child: Text(
                '${skills.name}',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: CommonText.style400S13.copyWith(
                  color: AppColors.blackk,
                ),
              ).animate().shimmer(),
            ),
            selected: false,
          );
        },
      ),
    );
  }
}

class CommonExpansionPanelList extends StatelessWidget {
  CommonExpansionPanelList({
    super.key,
    this.titleInfo,
    required this.child,
    this.expansionCallback,
    this.titleWidget,
    this.isExpand = false,
    this.isAddPadding = false,
    this.isPersonalInformation = false,
  });

  String? titleInfo;
  Widget child;
  Widget? titleWidget;
  Function(int, bool)? expansionCallback;
  bool isExpand;
  bool isAddPadding;
  bool isPersonalInformation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isPersonalInformation == false ? 0 : 15,
        left: isAddPadding == true ? 0 : 20,
        right: isAddPadding == true ? 0 : 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionPanelList(
          animationDuration: Duration(seconds: 1),
          expansionCallback: expansionCallback,
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: !isExpand,
              headerBuilder: (context, isExpanded) {
                return titleWidget ?? Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        titleInfo ?? AppString.basicInfo,
                        style: CommonText.style600S16.copyWith(
                          color: AppColors.blackk,
                        ),
                      ),
                    ),
                  ],
                );
              },
              body: child,
            ),
          ],
        ),
      ),
    );
  }
}
