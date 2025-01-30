import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.event, super.key});
  final Event event;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
    );
    bool isFavourite = userProvider.checkIsFavourite(event.id);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EventDetails.routeName, arguments: event);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(
                16.r,
              ),
            ),
            child: Image.asset(
              'assets/images/${event.category.imageName}.png',
            ),
          ),
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Apptheme.backgroundLight,
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
              color: Apptheme.backgroundLight,
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
                          color: Apptheme.black,
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
                        Provider.of<EventProvider>(context, listen: false)
                            .removeEventToFavourite(event.id);
                        Provider.of<EventProvider>(
                          context,
                          listen: false,
                        ).filterFavourites(userProvider.user!.favouriteIds);
                      } else {
                        userProvider.addEventToFavourite(event.id);
                        Provider.of<EventProvider>(context, listen: false)
                            .addEventToFavourite(event.id);
                      }
                    },
                    icon: Icon(
                      isFavourite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
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
