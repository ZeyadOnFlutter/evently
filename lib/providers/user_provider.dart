import 'package:evently/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;

  void updateUser(UserModel? usermodel) {
    user = usermodel;
    notifyListeners();
  }

  void addEventToFavourite(String eventId) {
    user!.favouriteIds.add(eventId);
    notifyListeners();
  }

  void removeEventToFavourite(String eventId) {
    user!.favouriteIds.remove(eventId);
    notifyListeners();
  }

  bool checkIsFavourite(String eventId) {
    return user!.favouriteIds.contains(eventId);
  }
}
