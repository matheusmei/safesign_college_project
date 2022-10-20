import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import 'package:safesign_app/core/widgets/main_buttom.dart';
import 'package:safesign_app/core/widgets/main_textfield.dart';
import 'package:safesign_app/core/widgets/return_button.dart';
import 'package:safesign_app/features/upload/view/widgets/custom_inform_dialog.dart';
import '../controller/upload_controller.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _controller = UploadController();

  @override
  void initState() {
    _controller.getUserModelList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.appDarkGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      ReturnButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: ColorsApp.appBlue,
                        strokeWidth: 3,
                        radius: const Radius.circular(15),
                        dashPattern: const [10, 5],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.insert_drive_file_rounded,
                                color: ColorsApp.appBlue,
                                size: 56,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Observer(builder: (_) {
                                return Text(
                                  _controller.selectedFile.path.isNotEmpty
                                      ? _controller.selectedFile.path
                                      : "Click here to add a document",
                                  textAlign: TextAlign.center,
                                  style: FontsApp.mainFontText24.copyWith(
                                      color: ColorsApp.appBlue,
                                      decoration: TextDecoration.underline),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        _controller.pickPdf();
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  Observer(builder: (_) {
                    return MainTextField(
                      labelText: "Document Name",
                      onChanged: _controller.changeDocumentName,
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (_) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _controller.isTileExpanded
                                ? ColorsApp.appBlue
                                : ColorsApp.appGrey,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: ExpansionTile(
                          expandedAlignment: Alignment.topCenter,
                          onExpansionChanged: (value) =>
                              _controller.changeTileExpansion(),
                          textColor: ColorsApp.appBlue,
                          iconColor: ColorsApp.appBlue,
                          collapsedTextColor: ColorsApp.appBlue,
                          collapsedIconColor: ColorsApp.appBlue,
                          title: Text(
                            "People Involved",
                            style: FontsApp.mainFontText16,
                          ),
                          children: [
                            for (var i = 0;
                                i < _controller.userList.length;
                                i++) ...[
                              ListTile(
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                title: Text(
                                  "${_controller.userList[i].firstName} ${_controller.userList[i].lastName}",
                                  style: FontsApp.mainFontText16.copyWith(
                                    color: ColorsApp.appLightGrey,
                                  ),
                                ),
                                onTap: () {
                                  _controller.addUserToSelectedList(
                                      _controller.userList[i]);
                                },
                              )
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _controller.selectedUserList.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                    "${_controller.selectedUserList[index].firstName} ${_controller.selectedUserList[index].lastName}",
                                    style: FontsApp.mainFontText16.copyWith(
                                        color: ColorsApp.appLightGrey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _controller.removeUserFromSelectedList(
                                        _controller.selectedUserList[index],
                                      );
                                    },
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: ColorsApp.appLightGrey,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Observer(builder: (_) {
                bool isLoading = _controller.isButtonAtLoadingStatus;
                return MainButtom(
                  onPressed: _controller.areDocumentsInfoValid
                      ? () async {
                          _controller.setButtonToLoadingStatus();
                          await _controller.uploadPdf();
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return CustomInformDialog(
                                    lottieUrl:
                                        'image/documentloadanimation.json',
                                    errorMessage: "Upload Succesful",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    });
                              }).then(
                            (_) async {
                              _controller.isButtonAtLoadingStatus = false;
                              Navigator.pop(context);
                            },
                          );
                        }
                      : null,
                  child: isLoading
                      ? Lottie.asset(
                          'image/loadinganimation.json',
                          height: 64,
                          width: 64,
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        )
                      : Text(
                          _controller.areDocumentsInfoValid
                              ? "Upload"
                              : "Invalid Infos",
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
    );
  }
}
