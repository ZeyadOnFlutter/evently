import 'package:evently/models/category.dart';
import 'package:evently/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  HomeBody({required this.currentIndex, super.key});
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return currentIndex == 0
        ? Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.h,
                );
              },
              itemCount: MyCategory.myCategory.length,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: index == MyCategory.myCategory.length - 1
                      ? EdgeInsets.only(
                          bottom: 75.h,
                        )
                      : EdgeInsets.zero,
                  child: CategoryItem(
                    index: index,
                  ),
                );
              },
            ),
          )
        : Padding(
            padding: EdgeInsets.all(16.r),
            child: CategoryItem(index: currentIndex),
          );
  }
}
