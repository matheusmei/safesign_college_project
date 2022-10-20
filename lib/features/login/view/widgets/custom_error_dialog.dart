import 'package:flutter/material.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import 'package:safesign_app/core/widgets/main_buttom.dart';
import '../../../../core/theme/colors_app.dart';

class CustomErrorDialog extends StatelessWidget {
  final String errorMessage;
  final void Function() onPressed;
  const CustomErrorDialog(
      {Key? key, required this.errorMessage, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipPath(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorsApp.appBlue, width: 3),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            color: ColorsApp.appDarkGrey.withOpacity(0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // child: BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: FontsApp.mainFontText24
                      .copyWith(color: ColorsApp.appLightGrey),
                ),
                const SizedBox(
                  height: 16,
                ),
                MainButtom(
                    onPressed: onPressed,
                    child: Text(
                      "Ok",
                      style: FontsApp.mainFontText24.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorsApp.appLightGrey),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
