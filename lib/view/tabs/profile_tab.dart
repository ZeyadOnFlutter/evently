import 'package:evently/connection/firebase_service.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/login.dart';
import 'package:evently/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileHeader(),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 87.h,
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                FirebaseService.logout().then(
                  (value) {
                    Provider.of<UserProvider>(context, listen: false)
                        .updateUser(null);
                    Navigator.of(context).pushReplacementNamed(Login.routeName);
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Apptheme.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(
                  16.r,
                ),
              ),
              label: Row(
                spacing: 8.w,
                children: [
                  Icon(
                    Icons.logout,
                    size: 24.r,
                    color: Apptheme.backgroundLight,
                  ),
                  Text(
                    'Logout',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Apptheme.backgroundLight,
                          fontSize: 20,
                        ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
