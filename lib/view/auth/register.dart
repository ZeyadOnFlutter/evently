import 'package:evently/connection/firebase_service.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/login.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/loading_indicator.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool isRegister = false;
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
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
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
                  hintText: 'Name',
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
                  hintText: 'Email',
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Apptheme.white : Apptheme.grey,
                  ),
                  prefixImageName: 'email',
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
                  hintText: 'Password',
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
                  hintText: 'Re Password',
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
                      print(passwordController.text);
                      print(value);
                      return 'Passwords do not match. Please try again';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                isRegister
                    ? LoadingIndicator()
                    : DefaultButton(
                        label: AppLocalizations.of(context)!.register,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isRegister = true;
                            });
                            FirebaseService.register(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ).then((user) {
                              Navigator.pushReplacementNamed(
                                context,
                                Login.routeName,
                              );
                            }).catchError((error) {
                              if (error is FirebaseAuthException) {
                                Fluttertoast.showToast(
                                  msg: error.message!,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Apptheme.primary,
                                  textColor: Colors.red,
                                  fontSize: 16.0,
                                );
                                setState(() {
                                  isRegister = false;
                                });
                              }
                            });
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
                        text: 'Already Have Account ? ',
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
                        text: 'Login',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
