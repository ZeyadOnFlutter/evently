import 'package:evently/connection/firebase_service.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/login.dart';
import 'package:evently/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});
  List<Language> languages = [
    Language(code: 'en', name: 'English'),
    Language(code: 'ar', name: 'العربية'),
  ];
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          const ProfileHeader(),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: settingsProvider.isDark
                            ? Apptheme.backgroundLight
                            : Apptheme.black,
                      ),
                ),
                Switch(
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.transparent,
                  thumbColor: const WidgetStatePropertyAll(Apptheme.primary),
                  trackOutlineColor:
                      const WidgetStatePropertyAll(Apptheme.primary),
                  thumbIcon: const WidgetStatePropertyAll(Icon(
                    Icons.circle,
                    color: Apptheme.primary,
                  )),
                  value: settingsProvider.isDark,
                  onChanged: (isDark) {
                    settingsProvider.changeTheme(
                      isDark ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: settingsProvider.isDark
                            ? Apptheme.backgroundLight
                            : Apptheme.black,
                      ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: settingsProvider.isDark
                        ? Apptheme.backgroundDark
                        : Apptheme.backgroundLight,
                    menuWidth: 100.w,
                    value: settingsProvider.languageCode,
                    borderRadius: BorderRadius.circular(16),
                    items: languages.map(
                      (languages) {
                        return DropdownMenuItem(
                          value: languages.code,
                          child: Text(
                            languages.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Apptheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      settingsProvider.changeLanguage(value!);
                    },
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
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

class Language {
  String code;
  String name;
  Language({required this.code, required this.name});
}
