import 'package:evently/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UtUtils {
  static void showLoading(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              content: SizedBox(
                height: 200.h,
                child: const Column(
                  children: [
                    LoadingIndicator(),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
