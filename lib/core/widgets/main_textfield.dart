import 'package:flutter/material.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';

class MainTextField extends StatefulWidget {
  final String? labelText;
  final IconButton? suffixIcon;
  final Icon? choosedIcon;
  final bool isObscure;
  final Function(String)? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;

  const MainTextField({
    Key? key,
    this.labelText,
    this.choosedIcon,
    this.isObscure = false,
    this.onChanged,
    this.suffixIcon,
    this.maxLength,
    this.keyboardType
  }) : super(key: key);

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      style: FontsApp.mainFontText16.copyWith(color: ColorsApp.appLightGrey),
      cursorColor: ColorsApp.appBlue,
      obscureText: widget.isObscure,
      decoration: InputDecoration(
        counter: const Offstage(),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.choosedIcon,
        labelText: widget.labelText,
        labelStyle: FontsApp.mainFontText16.copyWith(color: ColorsApp.appBlue),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: BorderSide(
            width: 2,
            color: ColorsApp.appGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: BorderSide(
            width: 2,
            color: ColorsApp.appBlue,
          ),
        ),
      ),
    );
  }
}
