import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/auth/login.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            color: Apptheme.black,
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
                  borderColor: Apptheme.grey,
                  textEditingController: emailController,
                  hintText: 'Name',
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Apptheme.grey,
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
                  borderColor: Apptheme.grey,
                  textEditingController: emailController,
                  hintText: 'Email',
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Apptheme.grey,
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
                DeafultTextFormField(
                  borderColor: Apptheme.grey,
                  textEditingController: repasswordController,
                  isPassword: true,
                  hintText: 'Re Password',
                  textInputType: TextInputType.text,
                  prefixImageName: 'lock',
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Apptheme.grey,
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
                LoginButton(
                  label: 'Create Account',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
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
