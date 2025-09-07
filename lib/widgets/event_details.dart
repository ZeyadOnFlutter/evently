import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../connection/firebase_service.dart';
import '../models/event.dart';
import '../providers/event_provider.dart';
import '../providers/settings_provider.dart';
import '../theme/apptheme.dart';
import '../view/update/update_event.dart';
import 'eventdetails_calendaritem.dart';
import 'eventdetails_locationitem.dart';

class EventDetails extends StatelessWidget {
  EventDetails({super.key});
  static const routeName = 'event_deatils';
  late Event event;

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    event = ModalRoute.of(context)?.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Deatils'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                UpdateEvent.routeName,
                arguments: event,
              );
            },
            child: SvgPicture.asset('assets/icons/edit.svg'),
          ),
          SizedBox(
            width: 10.w,
          ),
          InkWell(
            onTap: () {
              FirebaseService.deleteEventFromFireStore(event).then(
                (_) {
                  Provider.of<EventProvider>(context, listen: false).getEvents();
                  Navigator.of(context).pop();
                },
              );
            },
            child: SvgPicture.asset('assets/icons/delete.svg'),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            SizedBox(
              height: 16.h,
            ),
            ClipRRect(
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
            Text(
              event.description,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 24, color: Apptheme.primary),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventdetailsCalendaritem(event: event),
                    SizedBox(
                      height: 16.h,
                    ),
                    const EventdetailsLocationitem(),
                    SizedBox(
                      height: 16.h,
                    ),
                    Image.asset(
                      'assets/images/location.png',
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      event.description,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.1),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
