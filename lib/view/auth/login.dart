import 'package:evently/connection/firebase_service.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/register.dart';
import 'package:evently/view/home/home_screen.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    hintText: 'Email',
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ForgotPassword?',
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
                    label: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseService.login(
                          email: emailController.text,
                          password: passwordController.text,
                        ).then(
                          (user) {
                            Provider.of<UserProvider>(context, listen: false)
                                .updateUser(user);
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          },
                        ).catchError(
                          (error) {
                            if (error is FirebaseAuthException) {
                              Fluttertoast.showToast(
                                msg: error.message!,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                        );
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
                          text: 'Don’t Have Account ? ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, Register.routeName);
                            },
                          text: 'Create Account',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
