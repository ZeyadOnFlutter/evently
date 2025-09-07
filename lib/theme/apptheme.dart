import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Apptheme {
  static const Color primary = Color(0xFF5669FF);
  static const Color backgroundLight = Color(0xFFF2FEFF);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color black = Color(0xFF1C1C1C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF7B7B7B);
  static const Color red = Color(0xFFFF5659);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundLight,
      foregroundColor: black,
      centerTitle: true,
      surfaceTintColor: backgroundLight,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
      iconTheme: const IconThemeData(
        color: Apptheme.primary,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Apptheme.primary),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Apptheme.primary,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: Apptheme.backgroundLight,
      ),
      selectedItemColor: Apptheme.backgroundLight,
      unselectedItemColor: Apptheme.backgroundLight,
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: Apptheme.backgroundLight,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: backgroundLight,
      shape: CircleBorder(),
    ),
    textTheme: TextTheme(
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: primary,
      centerTitle: true,
      surfaceTintColor: backgroundDark,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
      iconTheme: const IconThemeData(
        color: Apptheme.primary,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: backgroundDark),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundDark,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: Apptheme.backgroundLight,
      ),
      selectedItemColor: Apptheme.backgroundLight,
      unselectedItemColor: Apptheme.backgroundLight,
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: Apptheme.backgroundLight,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: backgroundDark,
      foregroundColor: backgroundLight,
      shape: CircleBorder(),
    ),
    textTheme: TextTheme(
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    ),
  );
}
