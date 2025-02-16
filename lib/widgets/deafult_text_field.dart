import 'package:evently/providers/settings_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    this.isSearch = false,
    this.textCapitalization = TextCapitalization.none,
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
  final bool isSearch;
  final TextCapitalization textCapitalization;

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
      textCapitalization: widget.textCapitalization,
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
                colorFilter: ColorFilter.mode(
                  widget.isSearch
                      ? Provider.of<SettingsProvider>(context).isDark
                          ? Apptheme.primary
                          : Apptheme.primary
                      : Provider.of<SettingsProvider>(context).isDark
                          ? Apptheme.white
                          : Apptheme.grey,
                  BlendMode.srcIn,
                ),
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
                  color: Provider.of<SettingsProvider>(context).isDark
                      ? Apptheme.white
                      : Apptheme.grey,
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
