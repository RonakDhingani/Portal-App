import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:inexture/common_widget/text.dart';

import 'app_colors.dart';

class AssignedProjectTask extends StatelessWidget {
  AssignedProjectTask({
    super.key,
    required this.onTap,
    required this.projectName,
    required this.taskName,
    required this.code,
  });

  final Function() onTap;
  final String projectName;
  final String taskName;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: code,
                style: CommonText.style500S15.copyWith(
                  color: AppColors.yelloww,
                ),
              ),
              TextSpan(
                text: ' - ',
                style: CommonText.style500S15.copyWith(
                  color: AppColors.blackk,
                ),
              ),
              TextSpan(
                text: projectName,
                style: CommonText.style500S15.copyWith(
                  color: AppColors.blues,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(
          taskName,
          style: CommonText.style500S12.copyWith(
            color: AppColors.blackk,
          ),
        ),
        trailing: Icon(TablerIcons.eye),
      ),
    );
  }
}
