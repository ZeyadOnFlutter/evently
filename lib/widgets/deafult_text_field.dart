import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DeafultTextFormField extends StatefulWidget {
  const DeafultTextFormField({
    this.textEditingController,
    this.isPassword = false,
    this.validator,
    required this.hintText,
    this.prefixImageName,
    this.textInputType,
    this.onChanged,
    this.textStyle,
    required this.borderColor,
    super.key,
  });
  final TextEditingController? textEditingController;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String hintText;
  final String? prefixImageName;
  final TextInputType? textInputType;
  final void Function(String)? onChanged;
  final TextStyle? textStyle;
  final Color borderColor;

  @override
  State<DeafultTextFormField> createState() => _DeafultTextFormFieldState();
}

class _DeafultTextFormFieldState extends State<DeafultTextFormField> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      cursorColor: Apptheme.primary,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.textInputType,
      style: widget.textStyle,
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          'assets/icons/${widget.prefixImageName}.svg',
          fit: BoxFit.scaleDown,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Apptheme.grey,
                ),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: widget.textStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
      ),
      validator: widget.validator,
      obscureText: isObscure,
    );
  }
}
