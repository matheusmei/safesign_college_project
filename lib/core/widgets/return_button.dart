import 'package:flutter/material.dart';
import 'package:safesign_app/core/theme/colors_app.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: ColorsApp.appBlue,
        size: 32,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
