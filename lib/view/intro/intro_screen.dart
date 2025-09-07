import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/settings_provider.dart';
import '../../theme/apptheme.dart';
import '../../widgets/login_button.dart';
import '../onboard/slider_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const routeName = 'intro-screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int themeValue = 0;
  int languageValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/eventlylogo.png',
                  fit: BoxFit.cover,
                  height: 50.h,
                  width: 159.w,
                ),
              ),
              SizedBox(
                height: 44.h,
              ),
              Center(
                child: Image.asset(
                  'assets/images/intro_image.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'start_title'.tr(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Apptheme.primary,
                            ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'start_body'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              height: 1.2,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'language'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Apptheme.primary),
                          ),
                          AnimatedToggleSwitch<int>.rolling(
                            current: context.locale.toString() == 'en' ? 0 : 1,
                            borderWidth: 2,
                            spacing: 10.w,
                            values: const [0, 1],
                            onChanged: (i) {
                              setState(
                                () => languageValue = i,
                              );
                              context.setLocale(
                                languageValue == 0 ? const Locale('en') : const Locale('ar'),
                              );
                            },
                            iconBuilder: (value, foreground) => value == 0
                                ? SvgPicture.asset(
                                    'assets/icons/usa.svg',
                                    width: 35.w,
                                    height: 35.h,
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/egypt.svg',
                                    width: 35.w,
                                    height: 35.h,
                                    fit: BoxFit.cover,
                                  ),
                            iconsTappable: true,
                            style: ToggleStyle(
                              borderColor: Apptheme.primary,
                              indicatorColor: Apptheme.primary,
                              backgroundColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'theme'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Apptheme.primary),
                          ),
                          AnimatedToggleSwitch<int>.rolling(
                            current: Provider.of<SettingsProvider>(
                                      context,
                                      listen: false,
                                    ).themeMode ==
                                    ThemeMode.light
                                ? 0
                                : 1,
                            borderWidth: 2,
                            spacing: 10.w,
                            values: const [0, 1],
                            onChanged: (i) {
                              setState(
                                () => themeValue = i,
                              );
                              Provider.of<SettingsProvider>(
                                context,
                                listen: false,
                              ).changeTheme(
                                themeValue == 0 ? AppTheme.light : AppTheme.dark,
                              );
                            },
                            iconBuilder: (value, foreground) => value == 0
                                ? foreground
                                    ? const Icon(
                                        Icons.wb_sunny_outlined,
                                        color: Apptheme.white,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.wb_sunny_outlined,
                                        color: Apptheme.primary,
                                        size: 30,
                                      )
                                : foreground
                                    ? const Icon(
                                        Iconsax.moon,
                                        color: Apptheme.white,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Iconsax.moon,
                                        color: Apptheme.primary,
                                        size: 30,
                                      ),
                            iconsTappable: true,
                            style: ToggleStyle(
                              borderColor: Apptheme.primary,
                              indicatorColor: Apptheme.primary,
                              backgroundColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 28.h,
                        ),
                        child: DefaultButton(
                          label: 'lets_start'.tr(),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              SliderScreen.routeName,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
