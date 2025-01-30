import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category.dart';
import 'package:flutter/material.dart';

class Event {
  String id;
  String uId;
  MyCategory category;
  String title;
  String description;
  DateTime dateTime;

  Event({
    this.id = '',
    required this.uId,
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
  });
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      category: MyCategory.myCategory.firstWhere(
        (category) {
          return category.id == json['categoryId'];
        },
      ),
      uId: json['uId'],
      title: json['title'],
      description: json['description'],
      dateTime: (json['dateTime'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'uId': uId,
        'categoryId': category.id,
        'title': title,
        'description': description,
        'dateTime': Timestamp.fromDate(dateTime),
      };
}
