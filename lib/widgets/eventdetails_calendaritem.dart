import 'package:evently/models/event.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EventdetailsCalendaritem extends StatelessWidget {
  const EventdetailsCalendaritem({required this.event, super.key});
  final Event event;
  @override
  Widget build(BuildContext context) {
    TimeOfDay timeOfDay =
        TimeOfDay(hour: event.dateTime.hour, minute: event.dateTime.minute);
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: Apptheme.primary),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd MMMM yyyy').format(event.dateTime),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Apptheme.primary),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                format(context, timeOfDay),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Apptheme.primary),
              ),
            ],
          )
        ],
      ),
    );
  }

  String format(BuildContext context, TimeOfDay timeOfDay) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      timeOfDay,
      alwaysUse24HourFormat: false,
    );
  }
}
