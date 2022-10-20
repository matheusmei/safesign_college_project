import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:safesign_app/core/models/user_model.dart';
import '../../../core/models/doc_model.dart';
part 'document_status_controller.g.dart';

class DocumentStatusController = _DocumentStatusControllerBase
    with _$DocumentStatusController;

abstract class _DocumentStatusControllerBase with Store {
  @observable
  DocModel currentDoc = DocModel();

  @action
  void changeCurrentDoc(DocModel newValue) => currentDoc = newValue;

  @observable
  ObservableList<UserModel> pendingToSignList = <UserModel>[].asObservable();

  @observable
  ObservableList<UserModel> peopleInvolvedList = <UserModel>[].asObservable();

  @computed
  bool get isDocumentAvailable => pendingToSignList.isEmpty;

  @action
  Future<void> getDocInfoList() async {
    final document = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentDoc.ownerId)
        .collection("files")
        .doc(currentDoc.id)
        .get();
    final selectedDocument = DocModel.fromMap(document.data()!);
    final ObservableList<UserModel> peopleInvolvedUserList = <UserModel>[].asObservable();
    final ObservableList<UserModel> pendingToSignUserList = <UserModel>[].asObservable();
    for (var i = 0; i < selectedDocument.peopleInvolved!.length; i++) {
      final peopleInvolvedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(selectedDocument.peopleInvolved![i])
          .get();
          final userInvolved = UserModel.fromMap(peopleInvolvedDocument.data()!);
          peopleInvolvedUserList.add(userInvolved);
    }
        for (var i = 0; i < selectedDocument.pendingToSign!.length; i++) {
      final pendingToSignDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(selectedDocument.pendingToSign![i])
          .get();
          final userPendignToSign = UserModel.fromMap(pendingToSignDocument.data()!);
          pendingToSignUserList.add(userPendignToSign);
    }
    pendingToSignList = pendingToSignUserList;
    peopleInvolvedList = peopleInvolvedUserList;
  }

  @action
  Future<void> downloadPdf() async {
  Directory appDocDir = Directory('/storage/emulated/0/Download');
  File downloadToFile = File('${appDocDir.path}/Signed-${currentDoc.id}.pdf');
  String fileToDownload = "files/${currentDoc.ownerId}/${currentDoc.id}.pdf";
  try {
    await FirebaseStorage.instance
        .ref(fileToDownload)
        .writeToFile(downloadToFile);
  } on FirebaseException catch (e) {
    print('Download error: $e');
  }
}
}
