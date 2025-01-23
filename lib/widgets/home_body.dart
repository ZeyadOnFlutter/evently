import 'package:evently/models/event.dart';
import 'package:evently/models/firebase_service.dart';
import 'package:evently/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      getEvents();
    }
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 16.h,
          );
        },
        itemCount: events.length,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: index == events.length - 1
                ? EdgeInsets.only(
                    bottom: 75.h,
                  )
                : EdgeInsets.zero,
            child: CategoryItem(
              event: events[index],
            ),
          );
        },
      ),
    );
  }

  getEvents() async {
    events = await FirebaseService.getEventsFromFireStore();
    events.sort(
      (event, nextEvent) => event.dateTime.compareTo(nextEvent.dateTime),
    );
    setState(() {});
  }
}
