import 'package:evently/models/category.dart';
import 'package:evently/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mytabbar extends StatelessWidget {
  Mytabbar({
    required this.isCreateEvent,
    required this.tabBarLength,
    this.tabController,
    this.onTap,
    this.currentIndex = 0,
    super.key,
  });
  void Function(int)? onTap;
  int tabBarLength;
  bool isCreateEvent;
  int currentIndex;
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarLength,
      child: TabBar(
        controller: tabController,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        isScrollable: true,
        padding: EdgeInsets.only(
          left: 16.w,
          bottom: isCreateEvent ? 0 : 22.h,
        ),
        labelPadding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        onTap: onTap,
        tabs: isCreateEvent
            ? MyCategory.myCategory.skip(1).map(
                (myCategory) {
                  return TabItem(
                    myCategory: myCategory,
                    isSelected: currentIndex + 1 ==
                        MyCategory.myCategory.indexOf(
                          myCategory,
                        ),
                    isCreateEvent: isCreateEvent,
                  );
                },
              ).toList()
            : MyCategory.myCategory.map(
                (myCategory) {
                  return TabItem(
                    myCategory: myCategory,
                    isSelected: currentIndex ==
                        MyCategory.myCategory.indexOf(
                          myCategory,
                        ),
                    isCreateEvent: isCreateEvent,
                  );
                },
              ).toList(),
      ),
    );
  }
}
