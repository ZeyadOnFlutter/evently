import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/register.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    borderColor: Apptheme.grey,
                    textEditingController: emailController,
                    hintText: 'Email',
                    prefixImageName: 'email',
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Apptheme.grey,
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
                    borderColor: Apptheme.grey,
                    textEditingController: passwordController,
                    isPassword: true,
                    hintText: 'Password',
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Apptheme.grey,
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
                  LoginButton(
                    label: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
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
