import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../connection/firebase_service.dart';
import '../../providers/settings_provider.dart';
import '../../theme/apptheme.dart';
import '../../widgets/deafult_text_field.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/login_button.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const routeName = '/register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isRegister = true;
  int languageValue = 0;
  AwesomeDialog? awesomeRegisterDialog;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
          ),
        ),
      ),
      body: Padding(
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
                  textCapitalization: TextCapitalization.words,
                  borderColor: isDark ? Apptheme.primary : Apptheme.grey,
                  textEditingController: nameController,
                  hintText: 'name'.tr(),
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Apptheme.white : Apptheme.grey,
                  ),
                  prefixImageName: 'user',
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Name';
                    } else if (value.trim().length < 3) {
                      return 'Please Enter A Valid Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                DeafultTextFormField(
                  borderColor: isDark ? Apptheme.primary : Apptheme.grey,
                  textEditingController: emailController,
                  hintText: 'email'.tr(),
                  textInputFormatter: FilteringTextInputFormatter.allow(
                    RegExp(
                      r'^[a-zA-Z0-9@._-]*$',
                    ),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Apptheme.white : Apptheme.grey,
                  ),
                  prefixImageName: 'email',
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    final bool isValid = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(value!);
                    if (value.isEmpty) {
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
                  hintText: 'password'.tr(),
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
                DeafultTextFormField(
                  borderColor: isDark ? Apptheme.primary : Apptheme.grey,
                  textEditingController: repasswordController,
                  isPassword: true,
                  hintText: 're_password'.tr(),
                  textInputType: TextInputType.text,
                  prefixImageName: 'lock',
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Apptheme.white : Apptheme.grey,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Confirm Your Password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match. Please try again';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                DefaultButton(
                  label: 'register'.tr(),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseService.register(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        onLoading: () {
                          awesomeRegisterDialog = AwesomeDialog(
                            dismissOnTouchOutside: false,
                            btnOkColor: Apptheme.primary,
                            dialogBackgroundColor:
                                isDark ? Apptheme.backgroundDark : Apptheme.backgroundLight,
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
                        onSuccess: () {
                          AwesomeDialog(
                            onDismissCallback: (type) {
                              onRegiserSuccess(context);
                            },
                            dismissOnTouchOutside: false,
                            btnCancelColor: Colors.green,
                            btnOkColor: Apptheme.primary,
                            dialogBackgroundColor:
                                isDark ? Apptheme.backgroundDark : Apptheme.backgroundLight,
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.topSlide,
                            title: 'Success',
                            desc: 'User Created Successfully',
                            btnOkOnPress: () {
                              onRegiserSuccess(context);
                            },
                          ).show();
                        },
                        onError: (message) {
                          awesomeRegisterDialog!.dismiss();
                          AwesomeDialog(
                            btnCancelColor: const Color(0xfff44369),
                            btnOkColor: Apptheme.primary,
                            dialogBackgroundColor:
                                isDark ? Apptheme.backgroundDark : Apptheme.backgroundLight,
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.topSlide,
                            title: 'Error',
                            desc: message,
                            btnOkOnPress: () {},
                          ).show();
                        },
                      );
                      // then((user) {}).catchError((error) {
                      //   if (error is FirebaseAuthException) {
                      //     Fluttertoast.showToast(
                      //       msg: error.message!,
                      //       toastLength: Toast.LENGTH_LONG,
                      //       gravity: ToastGravity.BOTTOM,
                      //       timeInSecForIosWeb: 1,
                      //       backgroundColor: Apptheme.primary,
                      //       textColor: Colors.red,
                      //       fontSize: 16.0,
                      //     );
                      //     setState(() {
                      //       isRegister = false;
                      //     });
                      //   }
                      // });
                    }
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'already_have_account'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                              context,
                              Login.routeName,
                            );
                          },
                        text: 'login'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
          ),
        ),
      ),
    );
  }

  void onRegiserSuccess(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      Login.routeName,
    );
  }
}
