import 'package:evently/models/category.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.index, super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return MyCategory.myCategory[index].imageName != ''
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16.r,
                  ),
                ),
                child: Image.asset(
                  'assets/images/${MyCategory.myCategory[index].imageName}.png',
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Apptheme.backgroundLight,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '21',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 20, color: Apptheme.primary),
                      ),
                      Text(
                        'Nov',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 14, color: Apptheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 10.h,
                ),
                margin: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Apptheme.backgroundLight,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Meeting for Updating The Development Method',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontSize: 14,
                                  color: Apptheme.black,
                                ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                      width: 24.w,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Apptheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
