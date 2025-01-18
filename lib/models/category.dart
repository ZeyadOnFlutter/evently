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
      categoryName: 'All',
      iconName: Icons.explore_outlined,
      imageName: '',
    ),
    MyCategory(
      id: '1',
      categoryName: 'Sport',
      iconName: Icons.pedal_bike_outlined,
      imageName: 'sport',
    ),
    MyCategory(
      id: '2',
      categoryName: 'Birthday',
      iconName: Icons.cake_outlined,
      imageName: 'birthday',
    ),
    MyCategory(
      id: '3',
      categoryName: 'Meeting',
      iconName: Icons.business_center_outlined,
      imageName: 'meeting',
    ),
    MyCategory(
      id: '4',
      categoryName: 'Gaming',
      iconName: Icons.games_outlined,
      imageName: 'gaming',
    ),
    MyCategory(
      id: '5',
      categoryName: 'Eating',
      iconName: Icons.fastfood_outlined,
      imageName: 'eating',
    ),
    MyCategory(
      id: '6',
      categoryName: 'Holiday',
      iconName: Icons.beach_access_outlined,
      imageName: 'holiday',
    ),
    MyCategory(
      id: '7',
      categoryName: 'Exhibition',
      iconName: Icons.art_track_outlined,
      imageName: 'exhibition',
    ),
    MyCategory(
      id: '8',
      categoryName: 'Workshop',
      iconName: Icons.build_outlined,
      imageName: 'workshop',
    ),
    MyCategory(
      id: '9',
      categoryName: 'Book Club',
      iconName: Icons.menu_book_outlined,
      imageName: 'bookclub',
    ),
  ];
  static List<int> searchCategory = List.generate(
    MyCategory.myCategory.length,
    (index) {
      return index + 1;
    },
  );
  static void onSearch(String query) {
    searchCategory.clear();
    for (int i = 0; i < MyCategory.myCategory.length; i++) {
      if (MyCategory.myCategory[i].categoryName
          .toLowerCase()
          .contains(query.toLowerCase())) {
        searchCategory.add(i);
      }
    }
  }
}
