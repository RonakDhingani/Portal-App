import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/common_widget/asset.dart';
import 'package:inexture/common_widget/buttons.dart';
import 'package:inexture/common_widget/text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common_widget/app_colors.dart';
import '../../../../controller/main_home_controller.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage(
      {super.key, required this.text, this.isUserMessage = false});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['content'],
      isUserMessage: json['isUserMessage'] ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CrossAxisAlignment crossAxisAlignment =
        isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    var userDetails =
        Get.find<MainHomeController>().userProfileDetailsModel?.data;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isUserMessage
                ? Container()
                : Container(
                    height: 25.h,
                    width: 25.h,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    decoration: BoxDecoration(
                      color: AppColors.blackk,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        scale: 7.5,
                        image: AssetImage(
                          AssetImg.splashLogoImg,
                        ),
                      ),
                    ),
                  ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  right: isUserMessage ? 10 : 15,
                  left: isUserMessage ? 15 : 5,
                  top: 10,
                ),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isUserMessage ? AppColors.yelloww : AppColors.whitee,
                  borderRadius: isUserMessage
                      ? BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0.0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                ),
                child: !isUserMessage
                    ? markdownWidget(text)
                    : Text(
                        text,
                        style: CommonText.style500S16.copyWith(
                          color: AppColors.whitee,
                        ),
                      ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget markdownWidget(String markdownData) {
    return SelectionArea(
      child: Markdown(
        data: markdownData,
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        styleSheet: MarkdownStyleSheet(
          p: CommonText.style500S15.copyWith(
            color: AppColors.blackk.withOpacity(0.8),
          ),
          strong: CommonText.style600S15.copyWith(color: AppColors.blackk),
          pPadding: EdgeInsets.zero,
        ),
        onTapLink: (url, attributes, element) async {
          Uri uri = Uri.parse(url);
          if (!await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          )) {
            throw Exception('Could not launch $url');
          }
        },
      ),
    );
  }
}

class ErrorMessage extends ChatMessage {
  const ErrorMessage({super.key, required super.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whitee,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          maxLines: text.length,
          softWrap: true,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: CommonText.style500S15.copyWith(color: AppColors.redd),
        ),
      ),
    );
  }
}
