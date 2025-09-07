import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'providers/event_provider.dart';
import 'providers/location_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/user_provider.dart';
import 'theme/apptheme.dart';
import 'view/auth/login.dart';
import 'view/auth/register.dart';
import 'view/event/create_event.dart';
import 'view/home/home_screen.dart';
import 'view/intro/intro_screen.dart';
import 'view/onboard/slider_screen.dart';
import 'view/update/update_event.dart';
import 'widgets/event_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool hasSeenSlider = prefs.getBool('endSlider') ?? false;
  // String seenSlider =
  //     hasSeenSlider ? Register.routeName : SliderScreen.routeName;
  // String lang = prefs.getString('lang') ?? 'en';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider()..loadSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventProvider()..getEvents(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => LocationProvider()..fetchCurrentLocation(context),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        saveLocale: true,
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        path: 'assets/translations',
        child: const Evently(
          seenSlider: 'seenSlider',
          lang: 'lang',
        ),
      ),
    ),
  );
}

class Evently extends StatelessWidget {
  const Evently({required this.lang, required this.seenSlider, super.key});
  final String seenSlider;
  final String lang;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Evently',
          debugShowCheckedModeBanner: false,
          theme: Apptheme.lightTheme,
          darkTheme: Apptheme.darkTheme,
          themeMode: Provider.of<SettingsProvider>(context).themeMode,
          themeAnimationDuration: const Duration(milliseconds: 500),
          themeAnimationCurve: Curves.easeInOut,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: {
            Login.routeName: (_) => const Login(),
            Register.routeName: (_) => const Register(),
            HomeScreen.routeName: (_) => const HomeScreen(),
            CreateEvent.routeName: (_) => const CreateEvent(),
            SliderScreen.routeName: (_) => const SliderScreen(),
            EventDetails.routeName: (_) => EventDetails(),
            UpdateEvent.routeName: (_) => const UpdateEvent(),
            IntroScreen.routeName: (_) => const IntroScreen(),
          },
          initialRoute: IntroScreen.routeName,
        );
      },
    );
  }
}
