import 'package:flutter/material.dart';
import 'package:inexture/common_widget/text.dart';

import '../app_colors.dart';

class LableBoxUi {
  static Widget labelBoxUi({
    required BuildContext context,
    required String title,
    required String count,
    required Color color,
    required double elevation,
  }) {
    return Card(
      elevation: elevation,
      surfaceTintColor: color,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: elevation == 1.0 ? AppColors.transparent : color,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: CommonText.style500S15.copyWith(
                color: color,
              ),
            ),
            Spacer(),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whitee,
              ),
              child: Center(
                child: Text(
                  count,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: count.length == 4
                      ? CommonText.style500S13.copyWith(
                          color: color,
                        )
                      : CommonText.style500S15.copyWith(
                          color: color,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
