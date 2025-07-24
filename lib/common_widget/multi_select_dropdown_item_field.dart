// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:inexture/common_widget/text.dart';

import '../utils/utility.dart';
import 'app_colors.dart';
import 'app_string.dart';

class CustomMultiSelectDropDown extends StatelessWidget {
  CustomMultiSelectDropDown({
    required this.title,
    required this.items,
    required this.dropdownBuilder,
    required this.selectedItems,
    required this.onChanged,
    required this.isLoading,
    this.validator,
    this.isOptional,
    this.isVisible,
    this.isDropDownDisable,
    this.isForMeetingArea,
    this.hintText,
    super.key,
  });

  final String title;
  final List<String> items;
  final List<String> selectedItems;
  Widget Function(BuildContext, List<String>) dropdownBuilder;
  final Function(List<String>) onChanged;
  final bool isLoading;
  String? Function(List<String>?)? validator;
  bool? isOptional;
  bool? isVisible;
  bool? isDropDownDisable;
  bool? isForMeetingArea;
  String? hintText;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Utility.circleProcessIndicator()
        : Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.requiredText(title: title, isOptional: isOptional),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: DropdownSearch<String>.multiSelection(
                    enabled: isDropDownDisable ??
                        (isForMeetingArea != null ? false : true),
                    items: (filter, loadProps) => items,
                    popupProps: PopupPropsMultiSelection.menu(
                      searchFieldProps: TextFieldProps(
                        style: CommonText.style400S14.copyWith(
                          color: AppColors.blackk,
                        ),
                        decoration: InputDecoration(
                          hintText: '\t${AppString.searchDot}',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.yelloww,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyy,
                            ),
                          ),
                        ),
                      ),
                      showSelectedItems: true,
                      showSearchBox: true,
                      checkBoxBuilder: (context, item, isDisabled, isSelected) {
                        return Container();
                      },
                      itemBuilder: (context, item, isDisabled, isSelected) {
                        return ListTile(
                          leading: Text(
                            item,
                            style: CommonText.style400S14.copyWith(
                              color: isSelected
                                  ? AppColors.yelloww
                                  : AppColors.blackk,
                            ),
                          ),
                          trailing: Icon(
                            isSelected
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            color: isSelected
                                ? AppColors.yelloww
                                : AppColors.blackk,
                          ),
                        );
                      },
                    ),
                    dropdownBuilder: dropdownBuilder,
                    suffixProps: DropdownSuffixProps(
                      dropdownButtonProps: DropdownButtonProps(
                        isVisible: isVisible ?? false,
                        selectedIcon: Column(
                          children: [
                            Icon(
                              TablerIcons.chevron_up,
                              color: AppColors.greyyDark,
                              size: 14,
                            ),
                            Icon(
                              TablerIcons.chevron_down,
                              color: AppColors.greyyDark,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoratorProps: DropDownDecoratorProps(
                      baseStyle: CommonText.style400S13,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDropDownDisable == false
                            ? AppColors.greyy.withOpacity(0.2)
                            : AppColors.transparent,
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.greyy,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.yelloww,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.greyy,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.redd,
                          ),
                        ),
                        errorStyle: CommonText.style400S13.copyWith(
                          color: AppColors.redd,
                        ),
                        hintText: hintText ?? AppString.selectSendRequestTo,
                        hintStyle: CommonText.style400S14.copyWith(
                          color: AppColors.greyyDark,
                        ),
                        prefixIcon: const SizedBox(),
                        prefixIconConstraints: const BoxConstraints(
                          minHeight: 16,
                          minWidth: 16,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14.h,
                        ),
                      ),
                    ),
                    validator: validator ??
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select someone';
                          }
                          return null;
                        },
                    selectedItems: selectedItems,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          );
  }
}
