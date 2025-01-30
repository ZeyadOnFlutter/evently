import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/connection/firebase_service.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  // CLient Side
  //--------------------------------------------------------
  List<Event> events = [];
  List<Event> filteredEvents = [];
  List<Event> filteredFavourites = [];
  MyCategory selectedCategory = MyCategory.myCategory.first;

  Future<void> getEvents() async {
    events = await FirebaseService.getEventsFromFireStore();
    // events.sort(
    //   (event, nextEvent) => event.dateTime.compareTo(nextEvent.dateTime),
    // )
    filterEvents(selectedCategory);
    notifyListeners();
  }

  void filterEvents(MyCategory category) {
    selectedCategory = category;
    if (selectedCategory.id == '0') {
      filteredEvents = events;
    } else {
      filteredEvents = events.where(
        (event) {
          return event.category.id == selectedCategory.id;
        },
      ).toList();
    }
    notifyListeners();
  }

  Future<void> addEventToFavourite(String eventId) async {
    await FirebaseService.addEventToFavourite(eventId);
  }

  Future<void> removeEventToFavourite(String eventId) async {
    await FirebaseService.deleteEventFromFavourite(eventId);
  }

  void filterFavourites(List<String> favouriteIds) {
    filteredFavourites = events.where(
      (event) {
        return favouriteIds.contains(event.id);
      },
    ).toList();
    notifyListeners();
  }

  //------------------------------------------------------------------
  //Server Side
  //------------------------------------------------------------------
  // List<Event> events = [];
  // MyCategory selectedCategory = MyCategory.myCategory.first;
  // Future<void> getEvents() async {
  //   events = await FirebaseService.getEventsFromFireStore(selectedCategory.id);
  //   notifyListeners();
  // }

  // void changeCategory(MyCategory category) {
  //   selectedCategory = category;
  //   getEvents();
  // }
}
