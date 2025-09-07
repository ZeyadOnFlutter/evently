import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    EventProvider eventListProvider = Provider.of<EventProvider>(context);
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return eventListProvider.filteredEvents.isEmpty
        ? Expanded(
            child: Center(
              child: LottieBuilder.asset(
                isDark ? 'assets/lottie/event_dark.json' : 'assets/lottie/event.json',
              ),
            ),
          )
        : Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.h,
                );
              },
              itemCount: eventListProvider.filteredEvents.length,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: index == eventListProvider.filteredEvents.length - 1
                      ? EdgeInsets.only(
                          bottom: 75.h,
                        )
                      : EdgeInsets.zero,
                  child: CategoryItem(
                    event: eventListProvider.filteredEvents[index],
                  ),
                );
              },
            ),
          );
  }
}
