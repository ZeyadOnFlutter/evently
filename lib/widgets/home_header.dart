import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/event_provider.dart';
import '../providers/location_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/user_provider.dart';
import '../theme/apptheme.dart';
import 'icon_item.dart';
import 'mytabbar.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Provider.of<SettingsProvider>(context).isDark;
    final locationProvider = Provider.of<LocationProvider>(context);
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
                        // ignore: prefer_single_quotes
                        "welcome_back".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Apptheme.backgroundLight),
                      ),
                      Text(
                        Provider.of<UserProvider>(context).user!.name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      final SettingsProvider settingsProvider =
                          Provider.of<SettingsProvider>(context, listen: false);
                      settingsProvider.isDark
                          ? settingsProvider.changeTheme(AppTheme.light)
                          : settingsProvider.changeTheme(AppTheme.dark);
                    },
                    child: const Icon(
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
                                ? const Locale('ar')
                                : const Locale('en'),
                          );
                        },
                        child: Text(
                          context.locale.toString() == 'en' ? 'EN' : 'عربى',
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: 14,
                                color: isDark ? Apptheme.backgroundDark : Apptheme.primary,
                              ),
                        ),
                      ),
                    ),
                  ),
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
                    '${locationProvider.address ?? "cairo".tr()} , ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500, color: Apptheme.backgroundLight),
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
