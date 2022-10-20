import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import 'package:safesign_app/core/widgets/main_buttom.dart';
import '../../../../core/theme/colors_app.dart';

class CustomInformDialog extends StatelessWidget {
  final String lottieUrl;
  final String errorMessage;
  final void Function() onPressed;
  const CustomInformDialog(
      {Key? key, required this.errorMessage, required this.onPressed, required this.lottieUrl})
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  lottieUrl,
                  repeat: false
                ),
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
      // ),
    );
  }
}
