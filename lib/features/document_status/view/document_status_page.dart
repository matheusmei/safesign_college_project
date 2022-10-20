import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/core/widgets/custom_appbar.dart';
import 'package:safesign_app/core/widgets/main_buttom.dart';
import 'package:safesign_app/features/document_status/controller/document_status_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../core/models/doc_model.dart';
import '../../../core/theme/fonts_app.dart';
import '../../../core/widgets/return_button.dart';
import '../../upload/view/widgets/custom_inform_dialog.dart';

class DocumentStatusPage extends StatefulWidget {
  final DocModel currentDoc;
  const DocumentStatusPage({Key? key, required this.currentDoc})
      : super(key: key);

  @override
  State<DocumentStatusPage> createState() => _DocumentStatusPageState();
}

class _DocumentStatusPageState extends State<DocumentStatusPage> {
  final _controller = DocumentStatusController();

  @override
  void initState() {
    _controller.changeCurrentDoc(widget.currentDoc);
    _controller.getDocInfoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.appDarkGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _controller.currentDoc.id!,
                        style: FontsApp.mainFontText24.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorsApp.appLightGrey),
                      ),
                    ],
                  ),
                  Text(
                    "Status",
                    style: FontsApp.mainFontText20.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorsApp.appLightGrey),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (_) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _controller.peopleInvolvedList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorsApp.appBlue,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${_controller.peopleInvolvedList[index].firstName} ${_controller.peopleInvolvedList[index].lastName}",
                                        style: FontsApp.mainFontText16.copyWith(
                                            color: ColorsApp.appLightGrey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        _controller.pendingToSignList.contains(
                                                _controller
                                                    .peopleInvolvedList[index])
                                            ? Icons.access_time_rounded
                                            : Icons.check_rounded,
                                        color: ColorsApp.appBlue,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          );
                        },
                      );
                    },
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
                  Observer(
                    builder: (_) {
                      return MainButtom(
                          child: Text(
                            _controller.isDocumentAvailable
                                ? "Download"
                                : "Pending Signs",
                            style: FontsApp.mainFontText24.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorsApp.appLightGrey),
                          ),
                          onPressed: _controller.isDocumentAvailable
                              ? () async {
                                  await _controller.downloadPdf();
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomInformDialog(
                                        lottieUrl:
                                            'image/documentloadanimation.json',
                                        errorMessage: "File downloaded!",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                }
                              : null);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
