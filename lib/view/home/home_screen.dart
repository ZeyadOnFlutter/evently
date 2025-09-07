import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/location_provider.dart';
import '../../providers/settings_provider.dart';
import '../../theme/apptheme.dart';
import '../../widgets/icon_item.dart';
import '../event/create_event.dart';
import '../tabs/home_tab.dart';
import '../tabs/love_tab.dart';
import '../tabs/map_tab.dart';
import '../tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const MapTab(),
    const LoveTab(),
    const ProfileTab(),
  ];
  late final LocationProvider locationProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: ValueNotifier(EasyLocalization.of(context)!.currentLocale!),
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          bottomNavigationBar: SizedBox(
            child: BottomAppBar(
              padding: EdgeInsets.zero,
              elevation: 0,
              height: 60.h,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const CircularNotchedRectangle(),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const IconItem(iconName: 'home_icon'),
                    activeIcon: const IconItem(iconName: 'home_icon_active'),
                    label: 'home'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const IconItem(iconName: 'map_icon'),
                    activeIcon: const IconItem(iconName: 'map_icon_active'),
                    label: 'map'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const IconItem(iconName: 'love_icon'),
                    activeIcon: const IconItem(iconName: 'love_icon_active'),
                    label: 'love'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const IconItem(iconName: 'user_icon'),
                    activeIcon: const IconItem(iconName: 'user_icon_active'),
                    label: 'profile'.tr(),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            height: 51.h,
            width: 51.w,
            child: FloatingActionButton(
              onPressed: () async {
                Navigator.pushNamed(context, CreateEvent.routeName);
              },
              shape: CircleBorder(
                side: BorderSide(
                  color: Provider.of<SettingsProvider>(context).isDark
                      ? Colors.white
                      : Colors.transparent,
                  width: 5,
                ),
              ),
              child: SvgPicture.asset(
                'assets/icons/add_icon.svg',
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: tabs[currentIndex],
        );
      },
    );
  }
}
