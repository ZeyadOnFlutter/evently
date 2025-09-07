import 'package:flutter/material.dart';

class MyCategory {
  String id;
  String categoryName;
  IconData iconName;
  String imageName;
  MyCategory({
    required this.id,
    required this.categoryName,
    required this.iconName,
    required this.imageName,
  });
  static List<MyCategory> myCategory = [
    MyCategory(
      id: '0',
      categoryName: "all",
      iconName: Icons.explore_outlined,
      imageName: '',
    ),
    MyCategory(
      id: '1',
      categoryName: "sport",
      iconName: Icons.pedal_bike_outlined,
      imageName: 'sport',
    ),
    MyCategory(
      id: '2',
      categoryName: "birthday",
      iconName: Icons.cake_outlined,
      imageName: 'birthday',
    ),
    MyCategory(
      id: '3',
      categoryName: "meeting",
      iconName: Icons.business_center_outlined,
      imageName: 'meeting',
    ),
    MyCategory(
      id: '4',
      categoryName: "gaming",
      iconName: Icons.games_outlined,
      imageName: 'gaming',
    ),
    MyCategory(
      id: '5',
      categoryName: "eating",
      iconName: Icons.fastfood_outlined,
      imageName: 'eating',
    ),
    MyCategory(
      id: '6',
      categoryName: "holiday",
      iconName: Icons.beach_access_outlined,
      imageName: 'holiday',
    ),
    MyCategory(
      id: '7',
      categoryName: "exhibition",
      iconName: Icons.art_track_outlined,
      imageName: 'exhibition',
    ),
    MyCategory(
      id: '8',
      categoryName: "work_shop",
      iconName: Icons.build_outlined,
      imageName: 'workshop',
    ),
    MyCategory(
      id: '9',
      categoryName: "book_club",
      iconName: Icons.menu_book_outlined,
      imageName: 'bookclub',
    ),
  ];
}
