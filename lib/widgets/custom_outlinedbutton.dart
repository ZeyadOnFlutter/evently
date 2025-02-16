import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomOutlinedbutton extends StatelessWidget {
  CustomOutlinedbutton({required this.onPressed, super.key});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Apptheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      label: Text(
        'Login With Google',
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
