import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/ui/widget/dialog/info_dialog.dart';
import 'package:project_ta_ke_7/ui/widget/dialog/loading_dialog.dart';

class DialogUtils {

  static DialogUtils instance = DialogUtils();

  void showInfo(BuildContext context, String message, IconData icon, String buttonText, {Function onClick}) {
    showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(),
      builder: (context) {
        return InfoDialog(
          text: message,
          onClickOK: () => onClick != null ? onClick() : Navigator.pop(context),
          icon: icon,
          clickText: buttonText,
        );
      }
    );
  }

  void showOptions(BuildContext context, String message, IconData icon, {Function onClickYes}) {
    showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(),
      builder: (context) {
        return InfoDialog(
          text: message,
          onClickCancel: () => Navigator.pop(context),
          onClickOK: () => onClickYes != null ? onClickYes() : Navigator.pop(context),
          icon: icon,
        );
      }
    );
  }

  void showLoading(BuildContext context, String message) {
    showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(),
      builder: (context) {
        return LoadingDialog(
          text: message,
        );
      }
    );
  }
}