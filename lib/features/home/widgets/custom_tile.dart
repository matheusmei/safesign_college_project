
import 'package:flutter/material.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import '../../../core/theme/colors_app.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final int number;
  final Function()? action;
  const CustomTile({Key? key, required this.number, required this.title,  this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: ColorsApp.appGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(shape: BoxShape.circle, color: ColorsApp.appBlue),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: FontsApp.mainFontText24.copyWith(
                      color: ColorsApp.appLightGrey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: FontsApp.mainFontText24.copyWith(
                  color: ColorsApp.appLightGrey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
