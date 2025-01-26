import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/firebase_service.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  List<Event> events = [];
  List<Event> filteredEvents = [];
  MyCategory selectedCategory = MyCategory.myCategory.first;

  Future<void> getEvents() async {
    events = await FirebaseService.getEventsFromFireStore();
    // events.sort(
    //   (event, nextEvent) => event.dateTime.compareTo(nextEvent.dateTime),
    // )
    // changeCategory(selectedCategory);
    notifyListeners();
  }

  // void changeCategory(MyCategory category) {
  //   selectedCategory = category;
  //   if (selectedCategory.id == '0') {
  //     filteredEvents = events;
  //   } else {
  //     filteredEvents = events.where(
  //       (event) {
  //         return event.category.id == category.id;
  //       },
  //     ).toList();
  //   }
  //   notifyListeners();
  // }
}
