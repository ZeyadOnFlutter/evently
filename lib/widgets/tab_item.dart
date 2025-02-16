import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/category.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: isCreateEvent
            ? isSelected
                ? Apptheme.primary
                : Colors.transparent
            : isSelected
                ? isDark
                    ? Apptheme.primary
                    : Apptheme.backgroundLight
                : Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(46.r),
        ),
        border: Border.all(
          color: isCreateEvent
              ? Apptheme.primary
              : isDark
                  ? Apptheme.primary
                  : Apptheme.backgroundLight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            myCategory.iconName,
            color: isCreateEvent
                ? isSelected
                    ? isDark
                        ? Color(0xFF101127)
                        : Apptheme.backgroundLight
                    : Apptheme.primary
                : isSelected
                    ? isDark
                        ? Apptheme.backgroundLight
                        : Apptheme.primary
                    : Apptheme.backgroundLight,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            myCategory.categoryName.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: isCreateEvent
                      ? isSelected
                          ? isDark
                              ? Color(0xFF101127)
                              : Apptheme.backgroundLight
                          : Apptheme.primary
                      : isSelected
                          ? isDark
                              ? Apptheme.backgroundLight
                              : Apptheme.primary
                          : Apptheme.backgroundLight,
                ),
          ),
        ],
      ),
    );
  }
}
