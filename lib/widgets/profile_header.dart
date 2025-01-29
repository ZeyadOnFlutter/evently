import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
      child: Padding(
        padding: EdgeInsets.only(
          top: 64.h,
          left: 16.w,
          right: 16.w,
          bottom: 16.h,
        ),
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
                    Provider.of<UserProvider>(context).user?.name ?? '',
                    style: Theme.of(context).textTheme.displayMedium!,
                  ),
                  Text(
                    Provider.of<UserProvider>(context).user?.email ?? '',
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
    );
  }
}
