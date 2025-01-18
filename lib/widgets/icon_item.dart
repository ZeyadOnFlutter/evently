import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconItem extends StatelessWidget {
  const IconItem({required this.iconName, super.key});
  final String iconName;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      width: 24.w,
      height: 24.h,
      fit: BoxFit.scaleDown,
    );
  }
}
