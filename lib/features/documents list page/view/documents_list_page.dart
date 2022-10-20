import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:safesign_app/core/models/user_model_keys.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import 'package:safesign_app/core/widgets/custom_appbar.dart';
import 'package:safesign_app/core/widgets/custom_button.dart';
import 'package:safesign_app/core/widgets/return_button.dart';
import 'package:safesign_app/features/home/controller/home_controller.dart';
import 'package:safesign_app/features/sign_pdf/view/sign_pdf_page.dart';
import '../../document_status/view/document_status_page.dart';
import '../controller/documents_list_controller.dart';

class DocumentsListPage extends StatefulWidget {
  final String documentType;
  final String titlePage;
  const DocumentsListPage.toSign({
    Key? key,
    this.documentType = UserModelKeys.documentsToSign,
    this.titlePage = "Documents to sign",
  }) : super(key: key);
  const DocumentsListPage.available({
    this.titlePage = "Available Documents",
    this.documentType = UserModelKeys.availableDocuments,
    Key? key,
  }) : super(key: key);

  @override
  State<DocumentsListPage> createState() => _DocumentsListPageState();
}

class _DocumentsListPageState extends State<DocumentsListPage> {
  final _controller = DocumentsListController();

  @override
  void initState() {
    _controller.fetchDocumentByStatus(widget.documentType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.appDarkGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReturnButton(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.titlePage,
                          style: FontsApp.mainFontTitle32SemiBold
                              .copyWith(color: ColorsApp.appLightGrey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(
                builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.generalDocmentsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButton(
                            selectIcon: Icons.insert_drive_file_rounded,
                            text: _controller.generalDocmentsList[index].id!,
                            onPressed: () {
                              switch (widget.documentType) {
                                case UserModelKeys.documentsToSign:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignPdfPage(
                                        currentDoc: _controller
                                            .generalDocmentsList[index],
                                      ),
                                    ),
                                  );
                                  break;
                                case UserModelKeys.availableDocuments:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentStatusPage(
                                        currentDoc: _controller
                                            .generalDocmentsList[index],
                                      ),
                                    ),
                                  );
                                  break;
                              }
                            },
                          ),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
