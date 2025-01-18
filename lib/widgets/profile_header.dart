import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Apptheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(64.r),
        ),
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(top: 64.h),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16.w,
            children: [
              Image.asset(
                'assets/images/route.png',
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.h,
                  children: [
                    Text(
                      'John Safwat',
                      style: Theme.of(context).textTheme.displayMedium!,
                    ),
                    Text(
                      'johnsafwat.route@gmail.com',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Apptheme.backgroundLight,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
