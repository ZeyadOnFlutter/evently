import 'package:evently/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;

  void updateUser(UserModel? usermodel) {
    user = usermodel;
    notifyListeners();
  }
}
