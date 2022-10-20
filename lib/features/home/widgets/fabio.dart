import 'package:flutter/material.dart';
import '../../../core/theme/colors_app.dart';

class Fabio extends StatelessWidget {

  final Function() onPressed;

  const Fabio({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: ColorsApp.appBlue,
        ),
        child: Icon(Icons.add_rounded, color: ColorsApp.appLightGrey, size: 48,),
      ),
    );
  }
}