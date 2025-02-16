import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void showAlert({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "OK",
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Apptheme.primary,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Apptheme.backgroundLight),
          ),
          content: Text(
            content,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Apptheme.backgroundLight),
          ),
          actions: [
            TextButton(
              onPressed: onConfirm,
              child: Text(
                confirmText,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Apptheme.backgroundLight),
              ),
            ),
          ],
        );
      },
    );
  }
}
