import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:safesign_app/core/widgets/main_buttom.dart';
import 'package:safesign_app/core/widgets/return_button.dart';
import 'package:safesign_app/features/sign_pdf/controller/sign_pdf_controller.dart';
import 'package:safesign_app/features/sign_pdf/view/widgets/pin_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../core/models/doc_model.dart';
import '../../../core/theme/colors_app.dart';
import '../../../core/theme/fonts_app.dart';
import '../../upload/view/widgets/custom_inform_dialog.dart';

class SignPdfPage extends StatefulWidget {
  final DocModel currentDoc;
  const SignPdfPage({Key? key, required this.currentDoc}) : super(key: key);

  @override
  State<SignPdfPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignPdfPage> {
  final _controller = SignPdfController();

  @override
  void initState() {
    _controller.changeCurrentDoc(widget.currentDoc);
    _controller.getCurrentPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.appDarkGrey,
      body: Observer(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReturnButton(),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _controller.currentDoc.id!,
                          style: FontsApp.mainFontText24.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorsApp.appLightGrey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.67,
                  width: MediaQuery.of(context).size.height * 0.49,
                  child: SfPdfViewer.network(_controller.currentDoc.url!),
                ),
                SizedBox(
                  height: 24,
                ),
                MainButtom(
                  child: Text(
                    "Sign Document",
                    style: FontsApp.mainFontText24.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.appLightGrey),
                  ),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return PinDialog(
                          controller: _controller,
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
