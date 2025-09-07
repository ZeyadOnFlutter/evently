import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/apptheme.dart';

class CustomOutlinedbutton extends StatelessWidget {
  CustomOutlinedbutton({required this.onPressed, super.key});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Apptheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      label: Text(
        "login_with_google".tr(),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Apptheme.primary,
            ),
      ),
      icon: SvgPicture.asset(
        'assets/icons/google.svg',
      ),
    );
  }
}
