import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    this.maxLines = 1,
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
  final int? maxLines;

  @override
  State<DeafultTextFormField> createState() => _DeafultTextFormFieldState();
}

class _DeafultTextFormFieldState extends State<DeafultTextFormField> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.done,
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      cursorColor: Apptheme.primary,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.textInputType,
      style: widget.textStyle,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        prefixIcon: widget.prefixImageName != null
            ? SvgPicture.asset(
                'assets/icons/${widget.prefixImageName}.svg',
                fit: BoxFit.scaleDown,
              )
            : null,
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
