import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/event_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/user_provider.dart';
import '../theme/apptheme.dart';
import 'event_details.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.event, super.key});
  final Event event;

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    EventProvider eventProvider = Provider.of<EventProvider>(context, listen: false);
    bool isFavourite = userProvider.checkIsFavourite(event.id);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EventDetails.routeName, arguments: event);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.r,
                ),
              ),
              border: Border.all(
                color: isDark ? Apptheme.primary : Colors.transparent,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.r,
                ),
              ),
              child: Image.asset(
                isDark
                    ? 'assets/images/${event.category.imageName}dark.png'
                    : 'assets/images/${event.category.imageName}.png',
              ),
            ),
          ),
          PositionedDirectional(
            top: 8.h,
            start: context.locale.toString() == 'en' ? 8.w : 8.w,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isDark ? Apptheme.backgroundDark : Apptheme.backgroundLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('dd').format(event.dateTime),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 20, color: Apptheme.primary),
                  ),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 14, color: Apptheme.primary),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 10.h,
            ),
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDark ? Apptheme.backgroundDark : Apptheme.backgroundLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.description,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 14,
                          color: isDark ? Apptheme.backgroundLight : Apptheme.black,
                          height: 1.35.h,
                        ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (isFavourite) {
                        userProvider.removeEventToFavourite(event.id);
                        eventProvider.removeEventToFavourite(event.id);
                        eventProvider.filterFavourites(userProvider.user!.favouriteIds);
                      } else {
                        userProvider.addEventToFavourite(event.id);
                        eventProvider.addEventToFavourite(event.id);
                      }
                    },
                    icon: Icon(
                      isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: Apptheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
