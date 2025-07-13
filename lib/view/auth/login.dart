import 'dart:developer';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/connection/firebase_service.dart';
import 'package:evently/models/user.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/register.dart';
import 'package:evently/view/home/home_screen.dart';
import 'package:evently/widgets/custom_outlinedbutton.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/loading_indicator.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isGoogleLogin = true;
  bool isLogin = true;
  int languageValue = 0;
  AwesomeDialog? awesomeLoginDialog;
  AwesomeDialog? awesomeGoogleLoginDialog;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/evently_logo.png',
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  DeafultTextFormField(
                    borderColor: isDark ? Apptheme.primary : Apptheme.grey,
                    textEditingController: emailController,
                    hintText: "email".tr(),
                    prefixImageName: 'email',
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Apptheme.white : Apptheme.grey,
                    ),
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      final bool isValid = RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value!);
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      } else if (!isValid) {
                        return 'Please Enter A Valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  DeafultTextFormField(
                    borderColor: isDark ? Apptheme.primary : Apptheme.grey,
                    textEditingController: passwordController,
                    isPassword: true,
                    hintText: "password".tr(),
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Apptheme.white : Apptheme.grey,
                    ),
                    textInputType: TextInputType.text,
                    prefixImageName: 'lock',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      } else if (value.trim().length < 8) {
                        return 'Password Should Be More Than 8 Characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "forget_password".tr(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Apptheme.primary,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Apptheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  DefaultButton(
                    label: "login".tr(),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseService.login(
                          email: emailController.text,
                          password: passwordController.text,
                          onLoading: () {
                            awesomeLoginDialog = AwesomeDialog(
                              dismissOnTouchOutside: false,
                              btnOkColor: Apptheme.primary,
                              dialogBackgroundColor: isDark
                                  ? Apptheme.backgroundDark
                                  : Apptheme.backgroundLight,
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.topSlide,
                              title: 'Loading....',
                              desc: 'Loading....',
                              btnOk: Padding(
                                padding: EdgeInsets.all(16.h),
                                child: const LoadingIndicator(),
                              ),
                            )..show();
                          },
                          onError: (message) {
                            awesomeLoginDialog!.dismiss();
                            AwesomeDialog(
                              btnCancelColor: const Color(0xfff44369),
                              btnOkColor: Apptheme.primary,
                              dialogBackgroundColor: isDark
                                  ? Apptheme.backgroundDark
                                  : Apptheme.backgroundLight,
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.topSlide,
                              title: 'Error',
                              desc: message,
                              btnOkOnPress: () {},
                            ).show();
                            setState(() {
                              passwordController.clear();
                            });
                          },
                          onSuccess: (user) {
                            AwesomeDialog(
                              onDismissCallback: (type) {
                                onSignInSuccess(context, user);
                              },
                              btnCancelColor: Colors.green,
                              btnOkColor: Apptheme.primary,
                              dialogBackgroundColor: isDark
                                  ? Apptheme.backgroundDark
                                  : Apptheme.backgroundLight,
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              title: 'Success',
                              desc: 'User Created Successfully',
                              btnOkOnPress: () {
                                onSignInSuccess(context, user);
                              },
                            ).show();
                            setState(
                              () {
                                passwordController.clear();
                              },
                            );
                          },
                        );
                        //     .then(
                        //   (user) {

                        //   },
                        // ).catchError(
                        //   (error) {
                        //     if (error is FirebaseAuthException) {
                        //       Fluttertoast.showToast(
                        //         msg: error.message!,
                        //         toastLength: Toast.LENGTH_LONG,
                        //         gravity: ToastGravity.BOTTOM,
                        //         timeInSecForIosWeb: 1,
                        //         backgroundColor: Colors.red,
                        //         textColor: Colors.white,
                        //         fontSize: 16.0,
                        //       );
                        //       setState(() {
                        //         isLogin = false;
                        //       });
                        //     }
                        //   },
                        // );
                      }
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "do_not_have_account".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                context,
                                Register.routeName,
                              );
                            },
                          text: "create_account".tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Apptheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Apptheme.primary,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Apptheme.primary,
                          indent: 26.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "or".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Apptheme.primary),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Apptheme.primary,
                          endIndent: 26.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 57.67.h,
                    child: CustomOutlinedbutton(
                      onPressed: () async {
                        await FirebaseService.loginWithGoogle(
                          context,
                          () {
                            awesomeGoogleLoginDialog = AwesomeDialog(
                              dismissOnTouchOutside: false,
                              btnOkColor: Apptheme.primary,
                              dialogBackgroundColor: isDark
                                  ? Apptheme.backgroundDark
                                  : Apptheme.backgroundLight,
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.topSlide,
                              title: 'Loading....',
                              desc: 'Loading....',
                              btnOk: Padding(
                                padding: EdgeInsets.all(16.h),
                                child: const LoadingIndicator(),
                              ),
                            )..show();
                          },
                          (message) {
                            awesomeGoogleLoginDialog!.dismiss();
                            AwesomeDialog(
                              btnCancelColor: const Color(0xfff44369),
                              btnOkColor: Apptheme.primary,
                              dialogBackgroundColor: isDark
                                  ? Apptheme.backgroundDark
                                  : Apptheme.backgroundLight,
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.topSlide,
                              title: 'Error',
                              desc: message,
                              btnOkOnPress: () {},
                            ).show();
                          },
                          (message) {
                            awesomeGoogleLoginDialog!.dismiss();
                            AwesomeDialog(
                              btnCancelColor: const Color(0xfff44369),
                              btnOkColor: Apptheme.primary,
                              dialogBackgroundColor: isDark
                                  ? Apptheme.backgroundDark
                                  : Apptheme.backgroundLight,
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.topSlide,
                              title: 'Error',
                              desc: message,
                              btnOkOnPress: () {},
                            ).show();
                          },
                          (message, user) {
                            AwesomeDialog(
                              onDismissCallback: (type) {
                                onSignInSuccess(context, user);
                              },
                              btnCancelColor: Colors.green,
                              btnOkColor: Apptheme.primary,
                              dialogBackgroundColor: isDark
                                  ? Apptheme.backgroundDark
                                  : Apptheme.backgroundLight,
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              title: 'Success',
                              desc: 'User Created Successfully',
                              btnOkOnPress: () {
                                onSignInSuccess(context, user);
                              },
                            ).show();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
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
                        languageValue == 0 ? Locale('en') : Locale('ar'),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSignInSuccess(BuildContext context, UserModel user) {
    Provider.of<UserProvider>(
      context,
      listen: false,
    ).updateUser(user);
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
