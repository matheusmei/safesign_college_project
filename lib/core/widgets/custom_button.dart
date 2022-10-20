import 'package:flutter/material.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData? selectIcon;
  const CustomButton(
      {Key? key, required this.text, required this.onPressed, this.selectIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: ColorsApp.appGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Icon(
                selectIcon,
                color: ColorsApp.appBlue,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: FontsApp.mainFontText20
                      .copyWith(color: ColorsApp.appBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
