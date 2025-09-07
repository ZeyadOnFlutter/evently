import 'package:auto_size_text/auto_size_text.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/icon_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MapItem extends StatelessWidget {
  const MapItem({super.key, required this.event});
  final Event event;
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<SettingsProvider>(context).isDark;
    return Container(
      width: 321.w,
      height: 94.h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Apptheme.primary,
        ),
      ),
      child: Row(
        spacing: 10.w,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              isDark
                  ? "assets/images/${event.category.imageName}dark.png"
                  : "assets/images/${event.category.imageName}.png",
            ),
          ),
          Expanded(
            child: Column(
              spacing: 10.h,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  event.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Apptheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const IconItem(
                      iconName: 'black_map_icon',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        event.address ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600, color: Apptheme.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
