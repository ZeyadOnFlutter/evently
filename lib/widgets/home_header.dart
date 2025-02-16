import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/category.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/icon_item.dart';
import 'package:evently/widgets/mytabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return Container(
      width: double.infinity,
      height: 198.h,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: isDark ? Apptheme.backgroundDark : Apptheme.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "welcome_back".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Apptheme.backgroundLight),
                      ),
                      Text(
                        Provider.of<UserProvider>(context).user!.name,
                        style: Theme.of(context).textTheme.displayMedium!,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      SettingsProvider settingsProvider =
                          Provider.of<SettingsProvider>(context, listen: false);
                      settingsProvider.isDark
                          ? settingsProvider.changeTheme(ThemeMode.light)
                          : settingsProvider.changeTheme(ThemeMode.dark);
                    },
                    child: Icon(
                      Icons.wb_sunny_outlined,
                      color: Apptheme.backgroundLight,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: Apptheme.backgroundLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          context.setLocale(
                            context.locale.toString() == 'en'
                                ? Locale('ar')
                                : Locale('en'),
                          );
                        },
                        child: Text(
                          context.locale.toString() == 'en' ? 'EN' : 'عربى',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontSize: 14,
                                color: isDark
                                    ? Apptheme.backgroundDark
                                    : Apptheme.primary,
                              ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
              ),
              child: Row(
                children: [
                  const IconItem(
                    iconName: 'map_icon',
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${"cairo".tr()} , ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Apptheme.backgroundLight),
                  ),
                  Text(
                    "egypt".tr(),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Apptheme.backgroundLight,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Mytabbar(
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
                Provider.of<EventProvider>(
                  context,
                  listen: false,
                ).filterEvents(
                  MyCategory.myCategory[index],
                );
              },
              currentIndex: currentIndex,
              isCreateEvent: false,
              tabBarLength: MyCategory.myCategory.length,
            ),
          ],
        ),
      ),
    );
  }
}
