import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import 'package:safesign_app/core/widgets/main_buttom.dart';
import 'package:safesign_app/core/widgets/main_textfield.dart';
import 'package:safesign_app/features/sign_pdf/controller/sign_pdf_controller.dart';
import '../../../../core/theme/colors_app.dart';
import '../../../upload/view/widgets/custom_inform_dialog.dart';

class PinDialog extends StatelessWidget {
  PinDialog({Key? key, required this.controller}) : super(key: key);
  final SignPdfController controller;
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
                Text(
                  "Insert your pin to sign document",
                  style: FontsApp.mainFontText16.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorsApp.appLightGrey),
                ),
                const SizedBox(
                  height: 8,
                ),
                Observer(builder: (_) {
                  return MainTextField(
                    isObscure: true,
                    keyboardType: TextInputType.number,
                    onChanged: controller.changePin,
                    labelText: 'Pin',
                    maxLength: 4,
                    choosedIcon: Icon(
                      Icons.key_rounded,
                      color: ColorsApp.appBlue,
                    ),
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                Observer(builder: (_) {
                  return MainButtom(
                    onPressed: controller.isTypedPinValid
                        ? () async {
                            await controller.signDocument();
                            Navigator.pop(context);
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return CustomInformDialog(
                                  lottieUrl: 'image/signdocumentanimation.json',
                                  errorMessage: "Document Signed",
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          }
                        : null,
                    child: Text(
                      "Sign",
                      style: FontsApp.mainFontText24.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorsApp.appLightGrey),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
