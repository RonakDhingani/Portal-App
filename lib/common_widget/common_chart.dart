// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inexture/common_widget/text.dart';

import '../model/team_status_model.dart';
import 'app_colors.dart';
import 'app_string.dart';

class CommonChart extends StatefulWidget {
  final TeamStatusModel teamData;

  @override
  const CommonChart({super.key, required this.teamData});

  @override
  State<CommonChart> createState() => _CommonChartState();
}

class _CommonChartState extends State<CommonChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Indicator(
                isRight: false,
                color: AppColors.greenn,
                text: AppString.inOffice,
                subText: "${widget.teamData.data?.firstWhere(
                      (element) => element.name == AppString.inOffice,
                      orElse: () => Data(
                          name: AppString.inOffice,
                          value: 0,
                          count: 0,
                          color: "green.6"),
                    ).count ?? 0}",
              ),
              Indicator(
                isRight: true,
                color: AppColors.yelloww,
                text: AppString.halfDay,
                subText: "${widget.teamData.data?.firstWhere(
                      (element) => element.name == AppString.halfDay,
                      orElse: () => Data(
                          name: AppString.halfDay,
                          value: 0,
                          count: 0,
                          color: "green.6"),
                    ).count ?? 0}",
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
               PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 85,
                  borderData: FlBorderData(
                    show: true,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 40,
                  sections: showingSections(
                    teamStatusData: widget.teamData,
                  ),
                ),
                duration: Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
              ),
            ),
          ),
          Text(
            "${AppString.strength}: ${widget.teamData.totalEmployee}",
            style: CommonText.style600S15.copyWith(
              color: AppColors.whitee,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "${AppString.yourOverallTeamAttendanceIs} ${widget.teamData.overall}%",
            style: CommonText.style400S13.copyWith(
              color: AppColors.whitee,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Indicator(
                isRight: false,
                color: AppColors.blues,
                text: AppString.wfh,
                subText: "${widget.teamData.data?.firstWhere(
                      (element) => element.name == AppString.wfh,
                      orElse: () => Data(
                          name: AppString.wfh, value: 0, count: 0, color: "green.6"),
                    ).count ?? 0}",
              ),
              Indicator(
                isRight: true,
                color: AppColors.purplee,
                text: AppString.onLeave,
                subText: "${widget.teamData.data?.firstWhere(
                      (element) => element.name == AppString.onLeave,
                      orElse: () => Data(
                          name: AppString.onLeave,
                          value: 0,
                          count: 0,
                          color: "green.6"),
                    ).count ?? 0}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections({
    required TeamStatusModel teamStatusData,
  }) {
    return List.generate(
      teamStatusData.data?.length ?? 0,
      (i) {
        final isTouched = i == touchedIndex;
        final dataValue = teamStatusData.data?[i];
        final colorName = dataValue?.color;
        final color = getColorFromString(colorName);
        return PieChartSectionData(
          color: color,
          // gradient: color,
          value: dataValue?.value?.toDouble() ?? 0,
          title: "${dataValue?.value}%",
          radius: touchedIndex == i ? 60 : 50,
          titleStyle: CommonText.style600S16.copyWith(
              color: AppColors.whitee,
              shadows: [Shadow(color: AppColors.blackk, blurRadius: 5)]),
          showTitle: true,
          titlePositionPercentageOffset: 0.50,
          borderSide: BorderSide(
            color: AppColors.whitee,
            width: isTouched ? 2 : 0,
          ),
        );
      },
    );
  }

  LinearGradient getGradientFromString(String? colorName) {
    switch (colorName) {
      case 'green.6':
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.greenn,
            AppColors.yelloww,
          ],
        );
      case 'yellow.6':
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.blues,
            AppColors.yelloww,
          ],
        );
      case 'teal.3':
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.purplee,
            AppColors.blues,
          ],
        );
      case 'red.6':
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.greenn,
            AppColors.purplee,
          ],
        );
      default:
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.transparent,
            AppColors.transparent,
          ],
        );
    }
  }

  Color getColorFromString(String? colorName) {
    switch (colorName) {
      case 'green.6':
        return AppColors.greenn;
      case 'yellow.6':
        return AppColors.yelloww;
      case 'teal.3':
        return AppColors.blues;
      case 'red.6':
        return AppColors.purplee;
      default:
        return AppColors.transparent;
    }
  }

  static Indicator({
    required Color color,
    required String text,
    required String subText,
    required bool isRight,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: !isRight,
          child: Container(
            width: 10.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Container(
          height: 40.h,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: color.withOpacity(0.4),
            borderRadius: isRight
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )
                : BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
          ),
          child: Column(
            crossAxisAlignment:
                isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: CommonText.style600S16.copyWith(color: AppColors.whitee),
              ),
              Text(
                subText,
                style: CommonText.style400S13.copyWith(color: AppColors.whitee),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Visibility(
          visible: isRight,
          child: Container(
            width: 10.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
