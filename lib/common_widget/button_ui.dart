import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/app_string.dart';

import 'buttons.dart';

class ButtonUi extends StatelessWidget {
   ButtonUi({
    super.key,
    required this.onPressedSubmit,
    required this.isEnable,
    required this.isLoading,
    this.yes,
    this.no,
    this.clr,
  });

  String? yes;
  String? no;
  final bool isEnable;
  final bool isLoading;
  final Function() onPressedSubmit;
  Color? clr;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: [
          CustomElevatedButton(
            txt: yes ?? AppString.submit,
            isEnable: isEnable,
            isLoading: isLoading,
            onpressed: isLoading == true ? null : onPressedSubmit,
            clr: clr,
          ),
          SizedBox(
            width: 30,
          ),
          CustomOutLineButton(
            txt: no ?? AppString.cancel,
            isEnable: true,
            onpressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
