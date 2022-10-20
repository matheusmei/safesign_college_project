import 'package:flutter/material.dart';
import 'package:safesign_app/core/theme/colors_app.dart';

class MainButtom extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const MainButtom({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorsApp.appBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
