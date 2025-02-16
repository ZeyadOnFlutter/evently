import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const routeName = 'intro-screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
                height: 39.h,
              ),
              Text(
                'Personalize Your Experience',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Apptheme.primary,
                    ),
              ),
              SizedBox(
                height: 39.h,
              ),
              Text(
                'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      height: 1.2,
                    ),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  Text(
                    'Language',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Apptheme.primary),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Theme',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Apptheme.primary),
                  ),
                ],
              ),
              const Spacer(),
              DefaultButton(
                label: 'Let’s Start',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
