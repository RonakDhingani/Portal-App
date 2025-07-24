import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:inexture/common_widget/text.dart';

import 'app_colors.dart';
import 'app_string.dart';

class CommonDropdownMenu extends StatelessWidget {
  const CommonDropdownMenu({
    super.key,
    this.value,
    this.items,
    this.onChanged,
  });

  final String? value;
  final List<String>? items;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      value: value,
      onChanged: onChanged,
      underline: Container(),
      style: CommonText.style500S16.copyWith(
        color: AppColors.whitee,
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_outlined,
          color: AppColors.whitee,
        ),
      ),
      buttonStyleData: ButtonStyleData(
        overlayColor: WidgetStatePropertyAll(
          AppColors.transparent,
        ),
      ),
      hint: Row(
        children: [
          Text(
            "$value",
            style: CommonText.style500S16.copyWith(color: AppColors.whitee),
          ),
        ],
      ),
      items: items?.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(
            items,
            style: CommonText.style500S16.copyWith(
              color: AppColors.yelloww,
            ),
          ),
        );
      }).toList(),
      selectedItemBuilder: (context) {
        return items?.map((String item) {
              return Center(
                child: Text(
                  item,
                  style: CommonText.style500S16.copyWith(
                    color: AppColors.whitee,
                  ),
                ),
              );
            }).toList() ??
            [];
      },
    );
  }
}

class CommonDropdown extends StatelessWidget {
  final String? title;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hint;
  final bool isEnabled;
  final String? validatorText;
  final String? Function(String?)? validator;

  const CommonDropdown({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hint,
    this.isEnabled = true,
    this.validatorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.requiredText(title: title ?? ''),
        DropdownButtonFormField2<String>(
          value: selectedValue,
          hint: Text(
            hint,
            style: CommonText.style400S14.copyWith(
              color: AppColors.greyyDark,
            ),
          ),
          validator: validator ??
              (val) {
                if (val != null && val.isEmpty) {
                  return validatorText;
                }
                return null;
              },
          isExpanded: true,
          buttonStyleData: ButtonStyleData(
            overlayColor: WidgetStatePropertyAll(
              AppColors.transparent,
            ),
            width: 140.w,
            // height: 30.h,
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      value.toString(),
                      maxLines: 3,
                      softWrap: true,
                      style: CommonText.style500S15.copyWith(
                        color: AppColors.yelloww,
                      ),
                    ),
                  ),
                  Icon(
                    TablerIcons.point_filled,
                    color: value == selectedValue
                        ? AppColors.blackk
                        : AppColors.transparent,
                    size: 18,
                  ),
                ],
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return items.map((String item) {
              return Text(
                item,
                style: CommonText.style400S14.copyWith(
                  color: AppColors.blackk,
                ),
              );
            }).toList();
          },
          onChanged: isEnabled ? onChanged : null,
          disabledHint: Text(
            AppString.selectProjectFirst,
            style: CommonText.style400S14.copyWith(
              color: AppColors.greyyDark,
            ),
          ),
          style: TextStyle(color: Colors.black),
          iconStyleData: IconStyleData(
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
          ),
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.redd,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.redd,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.greyy,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.yelloww,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonDropdownMenuForYear extends StatelessWidget {
  const CommonDropdownMenuForYear({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.isDefaultSelected = false,
    this.dropdownValue,
  });

  final String? value;
  final List<String>? items;
  final Function(String?)? onChanged;
  final bool isDefaultSelected;
  final String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      value: value,
      underline: Container(),
      onChanged: onChanged,
      style: CommonText.style500S16.copyWith(
        color: AppColors.whitee,
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_outlined,
          color: AppColors.whitee,
        ),
      ),
      buttonStyleData: ButtonStyleData(
        overlayColor: WidgetStatePropertyAll(
          AppColors.transparent,
        ),
        width: 138.w,
        height: 40.h,
      ),
      hint: Row(
        children: [
          Icon(
            TablerIcons.calendar,
            color: AppColors.whitee,
            size: 20,
          ),
          SizedBox(width: 8.w),
          Text(
            "$dropdownValue",
            style: CommonText.style500S16.copyWith(color: AppColors.whitee),
          ),
        ],
      ),
      items: items
          ?.map(
            (String item) => DropdownMenuItem(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    item,
                    style: CommonText.style500S16.copyWith(
                      color: AppColors.yelloww,
                    ),
                  ),
                  Icon(
                    TablerIcons.point_filled,
                    color: item == dropdownValue
                        ? AppColors.blackk
                        : AppColors.transparent,
                    size: 18,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      selectedItemBuilder: (context) {
        return items?.map((String item) {
              return Row(
                children: [
                  Icon(
                    TablerIcons.calendar,
                    color: AppColors.whitee,
                    size: 20,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    item,
                    style: CommonText.style500S16.copyWith(
                      color: AppColors.whitee,
                    ),
                  ),
                ],
              );
            }).toList() ??
            [];
      },
    );
  }
}
