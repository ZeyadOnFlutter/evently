import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/icon_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EventdetailsLocationitem extends StatelessWidget {
  const EventdetailsLocationitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: Apptheme.primary),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Apptheme.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(
              'assets/icons/whitecalendar.svg',
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            'Cairo , Egypt',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Apptheme.primary),
          ),
          const Spacer(),
          const IconItem(
            iconName: 'bluearrowright',
          ),
        ],
      ),
    );
  }
}
