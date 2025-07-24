import 'package:flutter/material.dart';
import 'package:inexture/common_widget/common_flutter_switch.dart';

import '../../../../common_widget/app_colors.dart';
import '../../../../common_widget/text.dart';

class AdhocAddOnDropDown extends StatelessWidget {
  const AdhocAddOnDropDown({
    super.key,
    required this.value,
    required this.onToggle,
    required this.title,
    required this.statusTitle,
    required this.hintText,
    required this.visible,
    required this.dropdownMenuEntries,
    required this.controller,
    this.onSelected,
  });

  final bool value;
  final Function(bool) onToggle;
  final String title;
  final String statusTitle;
  final String hintText;
  final bool visible;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;
  final TextEditingController controller;
  final Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonFlutterSwitch(value: value, onToggle: onToggle, title: title),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: visible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.requiredText(title: statusTitle),
                DropdownMenu(
                  controller: controller,
                  onSelected: onSelected,
                  textStyle: CommonText.style500S15.copyWith(
                    color: AppColors.blackk,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: hintText,
                  dropdownMenuEntries: dropdownMenuEntries,
                  menuHeight: 300,
                  inputDecorationTheme: InputDecorationTheme(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.yelloww),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.greyy),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.redd),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
