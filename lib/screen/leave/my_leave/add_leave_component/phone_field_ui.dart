import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../common_widget/app_colors.dart';
import '../../../../common_widget/app_string.dart';
import '../../../../common_widget/text.dart';

class PhoneFieldUi extends StatelessWidget {
  const PhoneFieldUi({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.validator,
    this.phoneError,
  });

  final TextEditingController controller;
  final Function(PhoneNumber)? onChanged;
  final Function(PhoneNumber?)? onSaved;
  final Function(String)? onSubmitted;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final String? phoneError;
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
          Text(
            AppString.emergencyContactNumber,
            style: CommonText.style500S15.copyWith(
              color: AppColors.blackk,
            ),
          ),
          SizedBox(height: 5,),
          IntlPhoneField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.yelloww),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyy),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.redd),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyy),
              ),
              errorText: phoneError,
            ),
            disableLengthCheck: false,
            initialCountryCode: 'IN',
            controller: controller,
            onChanged: onChanged,
            onSaved: onSaved,
            onSubmitted: onSubmitted,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
