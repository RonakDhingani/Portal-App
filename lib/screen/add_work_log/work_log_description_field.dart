import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:inexture/common_widget/app_string.dart';

import '../../common_widget/app_colors.dart';
import '../../common_widget/text.dart';

class WorkLogDescriptionField extends StatefulWidget {
  WorkLogDescriptionField({
    super.key,
    required this.controller,
    this.isEodShow,
    required this.isFocused,
    required this.isRequired,
    this.onTap,
    this.onPaste,
    this.fieldTitle,
    this.hintText,
    this.focusNode,
  });

  QuillController controller;
  bool? isEodShow;
  bool isRequired = true;
  bool isFocused = false;
  Function()? onTap;
  Function()? onPaste;
  String? fieldTitle;
  String? hintText;
  final FocusNode? focusNode;

  @override
  State<WorkLogDescriptionField> createState() =>
      _WorkLogDescriptionFieldState();
}

class _WorkLogDescriptionFieldState extends State<WorkLogDescriptionField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Visibility(
          visible: widget.isRequired == true,
          child: Column(
            children: [
              CommonText.requiredText(
                  title: widget.fieldTitle ?? AppString.workDescription),
              SizedBox(height: 5),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isFocused ? AppColors.yelloww : AppColors.greyy,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Row(
            children: [
              quill.QuillSimpleToolbar(
                controller: widget.controller,
                config: quill.QuillSimpleToolbarConfig(
                  showAlignmentButtons: false,
                  showBackgroundColorButton: false,
                  showCenterAlignment: false,
                  showClearFormat: false,
                  showClipboardCopy: false,
                  showClipboardCut: false,
                  showClipboardPaste: true,
                  showCodeBlock: false,
                  showColorButton: false,
                  showDirection: false,
                  showDividers: false,
                  showFontFamily: false,
                  showFontSize: false,
                  showHeaderStyle: false,
                  showIndent: false,
                  showInlineCode: false,
                  showJustifyAlignment: false,
                  showLeftAlignment: false,
                  showLink: false,
                  showListCheck: false,
                  showQuote: false,
                  showRedo: false,
                  showRightAlignment: false,
                  showSearchButton: false,
                  showSmallButton: false,
                  showStrikeThrough: false,
                  showSubscript: false,
                  showSuperscript: false,
                  showUndo: false,
                  toolbarSectionSpacing: 0.0.sp,
                  customButtons: [
                    if (widget.isEodShow == true)
                      QuillToolbarCustomButtonOptions(
                        icon: Column(
                          children: [
                            Icon(
                              TablerIcons.history,
                              color: AppColors.blackk,
                              size: 15.sp,
                            ),
                            Text(
                              AppString.history,
                              textAlign: TextAlign.center,
                              style: CommonText.style700S13.copyWith(
                                color: AppColors.blackk,
                                fontSize: 6.sp
                              ),
                            ),
                          ],
                        ),
                        onPressed: widget.onTap,
                      ),
                  ],
                  buttonOptions: QuillSimpleToolbarButtonOptions(
                    bold: QuillToolbarToggleStyleButtonOptions(
                        childBuilder: (dynamic opts, dynamic extra) {
                      return Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: extra.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.greyy,
                            ),
                            left: BorderSide(
                              color: extra.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.greyy,
                            ),
                            bottom: BorderSide(
                              color: extra.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.greyy,
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.r),
                            bottomLeft: Radius.circular(5.r),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: extra.onPressed,
                          child: Icon(
                            Icons.format_bold_outlined,
                            color: extra.isToggled == true
                                ? AppColors.yelloww
                                : AppColors.blackk,
                          ),
                        ),
                      );
                    }),
                    italic: QuillToolbarToggleStyleButtonOptions(
                      childBuilder: (dynamic opts, dynamic toolbarButtons) {
                        return Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: toolbarButtons.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.greyy,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: toolbarButtons.onPressed,
                            child: Icon(
                              Icons.format_italic_outlined,
                              color: toolbarButtons.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.blackk,
                            ),
                          ),
                        );
                      },
                    ),
                    underLine: QuillToolbarToggleStyleButtonOptions(
                      childBuilder: (dynamic options, dynamic toolbarButtons) {
                        return Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              right: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              bottom: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.r),
                              bottomRight: Radius.circular(5.r),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: toolbarButtons.onPressed,
                            child: Icon(
                              Icons.format_underline_outlined,
                              color: toolbarButtons.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.blackk,
                            ),
                          ),
                        );
                      },
                    ),
                    listNumbers: QuillToolbarToggleStyleButtonOptions(
                      childBuilder: (dynamic options, dynamic toolbarButtons) {
                        return Container(
                          margin: EdgeInsets.only(left: 10.w),
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              left: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              right: BorderSide(
                                width: 0.5,
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              bottom: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.r),
                              bottomLeft: Radius.circular(5.r),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: toolbarButtons.onPressed,
                            child: Icon(
                              Icons.format_list_numbered_outlined,
                              color: toolbarButtons.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.blackk,
                            ),
                          ),
                        );
                      },
                    ),
                    listBullets: QuillToolbarToggleStyleButtonOptions(
                      childBuilder: (dynamic options, dynamic toolbarButtons) {
                        return Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              left: BorderSide(
                                width: 0.5,
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              right: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                              bottom: BorderSide(
                                color: toolbarButtons.isToggled == true
                                    ? AppColors.yelloww
                                    : AppColors.greyy,
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.r),
                              bottomRight: Radius.circular(5.r),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: toolbarButtons.onPressed,
                            child: Icon(
                              Icons.format_list_bulleted_outlined,
                              color: toolbarButtons.isToggled == true
                                  ? AppColors.yelloww
                                  : AppColors.blackk,
                            ),
                          ),
                        );
                      },
                    ),
                    clipboardPaste: QuillToolbarClipboardButtonOptions(
                      childBuilder: (dynamic options, dynamic extraOptions) {
                        return Container(
                          margin: EdgeInsets.only(left: 10.w),
                          padding: EdgeInsets.all(4.sp),
                          child: GestureDetector(
                            onTap: widget.onPaste,
                            child: Icon(
                              Icons.content_paste,
                              color: AppColors.blackk,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.2 - 20),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: widget.isFocused ? AppColors.yelloww : AppColors.greyy,
              ),
              right: BorderSide(
                color: widget.isFocused ? AppColors.yelloww : AppColors.greyy,
              ),
              bottom: BorderSide(
                color: widget.isFocused ? AppColors.yelloww : AppColors.greyy,
              ),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: quill.QuillEditor.basic(
            controller: widget.controller,
            focusNode: widget.focusNode ?? FocusNode(),
            config: quill.QuillEditorConfig(
              autoFocus: false,
              expands: false,
              scrollable: true,
              showCursor: true,
              placeholder: widget.hintText ?? AppString.addYourEOD,
              padding: EdgeInsets.all(10),
              textSelectionThemeData: TextSelectionThemeData(
                cursorColor: AppColors.yelloww,
                selectionColor: AppColors.yelloww.withValues(alpha: 0.3),
                selectionHandleColor: AppColors.yelloww,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
