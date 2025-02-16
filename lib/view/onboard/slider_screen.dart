import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/login.dart';
import 'package:evently/view/auth/register.dart';
import 'package:evently/view/home/home_screen.dart';
import 'package:evently/view/onboard/slider_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});
  static const routeName = 'slider-screen';
  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();
  bool isLastPage = false;
  bool get isEnglish => context.locale.toString() == 'en';
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/eventlylogo.png',
                fit: BoxFit.cover,
                height: 50.h,
                width: 159.w,
              ),
              SizedBox(
                height: 44.h,
              ),
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: MySlider.sliderHeader.length,
                  controller: pageController,
                  onPageChanged: (value) {
                    currentIndex = value;
                    isLastPage = value == MySlider.sliderHeader.length - 1;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/onboard/${index + 1}.png'),
                        SizedBox(
                          height: 39.h,
                        ),
                        Text(
                          MySlider.sliderHeader[index].tr(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Apptheme.primary,
                                  ),
                        ),
                        SizedBox(
                          height: 39.h,
                        ),
                        Text(
                          MySlider.sliderDescription[index].tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    height: 1.2,
                                  ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentIndex == 0
                        ? SizedBox(
                            height: 37.6.h,
                            width: 37.6.w,
                          )
                        : InkWell(
                            onTap: () {
                              currentIndex--;
                              pageController.animateToPage(
                                currentIndex,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            },
                            child: isDark
                                ? isEnglish
                                    ? SvgPicture.asset(
                                        'assets/icons/arrowleft.svg',
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/arrowright.svg',
                                      )
                                : isEnglish
                                    ? SvgPicture.asset(
                                        'assets/icons/rightarrow.svg',
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/leftarrow.svg',
                                      ),
                            //isDark
                            //      SvgPicture.asset(
                            //         'assets/icons/arrowleft.svg',
                            //       )
                            //     : SvgPicture.asset(
                            //         'assets/icons/rightarrow.svg',
                            //       ),
                          ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (index) {
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      effect: ExpandingDotsEffect(
                        dotHeight: 8.h,
                        dotWidth: 8.h,
                        dotColor: isDark ? Apptheme.white : Apptheme.black,
                        activeDotColor: Apptheme.primary,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (isLastPage) {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setBool('endSlider', true);
                          Navigator.pushReplacementNamed(
                            context,
                            Register.routeName,
                          );
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: isDark
                          ? isEnglish
                              ? SvgPicture.asset(
                                  'assets/icons/arrowright.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/arrowleft.svg',
                                )
                          : isEnglish
                              ? SvgPicture.asset(
                                  'assets/icons/leftarrow.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/rightarrow.svg',
                                ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
