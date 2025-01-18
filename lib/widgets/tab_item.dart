import 'package:evently/models/category.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabItem extends StatelessWidget {
  TabItem({
    required this.isCreateEvent,
    required this.myCategory,
    required this.isSelected,
    super.key,
  });
  MyCategory myCategory;
  bool isSelected;
  bool isCreateEvent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: isCreateEvent
            ? isSelected
                ? Apptheme.primary
                : Colors.transparent
            : isSelected
                ? Apptheme.backgroundLight
                : Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(46.r),
        ),
        border: Border.all(
          color: isCreateEvent ? Apptheme.primary : Apptheme.backgroundLight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            myCategory.iconName,
            color: isCreateEvent
                ? isSelected
                    ? Apptheme.backgroundLight
                    : Apptheme.primary
                : isSelected
                    ? Apptheme.primary
                    : Apptheme.backgroundLight,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            myCategory.categoryName,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: isCreateEvent
                      ? isSelected
                          ? Apptheme.backgroundLight
                          : Apptheme.primary
                      : isSelected
                          ? Apptheme.primary
                          : Apptheme.backgroundLight,
                ),
          ),
        ],
      ),
    );
  }
}
