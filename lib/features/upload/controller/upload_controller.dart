import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:safesign_app/core/models/user_model_keys.dart';
import '../../../core/models/user_model.dart';
part 'upload_controller.g.dart';

class UploadController = _UploadControllerBase with _$UploadController;

abstract class _UploadControllerBase with Store {
  final user = FirebaseAuth.instance.currentUser!;

  @observable
  String documentName = '';

  @action
  void changeDocumentName(String newValue) => documentName = newValue;

  @observable
  bool isTileExpanded = false;

  @action
  void changeTileExpansion() => isTileExpanded = !isTileExpanded;

  @observable
  ObservableList<UserModel> userList = <UserModel>[].asObservable();

  @action
  Future<List<UserModel>> getUserModelList() async {
    final documents =
        await FirebaseFirestore.instance.collection("users").get();
    userList = documents.docs
        .map((e) => UserModel.fromMap(e.data()))
        .toList()
        .asObservable();
    return userList;
  }

  @observable
  ObservableList<UserModel> selectedUserList = <UserModel>[].asObservable();

  @action
  void addUserToSelectedList(UserModel selectedUserModel) {
    if (!selectedUserList.contains(selectedUserModel)) {
      selectedUserList.add(selectedUserModel);
    }
  }

  @action
  void removeUserFromSelectedList(UserModel selectedUserModel) {
    if (selectedUserList.contains(selectedUserModel)) {
      selectedUserList.remove(selectedUserModel);
    }
  }

  @computed
  bool get isDocumentNameValid =>
      documentName.isNotEmpty && documentName.length >= 6;

  @computed
  bool get isPeopleInvolvedValid =>
      selectedUserList.isNotEmpty && selectedUserList != [];

  @computed
  bool get areDocumentsInfoValid =>
      isDocumentNameValid &&
      isPeopleInvolvedValid &&
      selectedFile.path.isNotEmpty;

  @observable
  bool isButtonAtLoadingStatus = false;

  @action
  void setButtonToLoadingStatus() => isButtonAtLoadingStatus = true;

  @observable
  File selectedFile = File("");

  @action
  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedFile = File(result.files.single.path!);
    } else {}
  }

  @action
  Future<void> uploadPdf() async {
    try {
      List<String> selectedIdUserList = [];
      for (var i = 0; i < selectedUserList.length; i++) {
        selectedIdUserList.add(selectedUserList[i].id!);
      }
      String ref = "files/${user.uid}/$documentName.pdf";
      await FirebaseStorage.instance.ref(ref).putFile(selectedFile);
      final fileUrl =
          await FirebaseStorage.instance.ref().child(ref).getDownloadURL();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("files")
          .doc(documentName)
          .set(
        {
          "url": fileUrl,
          "_id": documentName,
          "owner_id": user.uid,
          "people_involved": selectedIdUserList,
          "pending_to_sign": selectedIdUserList,
        },
      );
      for (var i = 0; i < selectedUserList.length; i++) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(selectedUserList[i].id)
            .collection(UserModelKeys.documentsToSign)
            .doc(documentName)
            .set({
          "_id": documentName,
          "owner_id": user.uid,
          "url": fileUrl,
        });
      }
    } on FirebaseException catch (e) {
      throw Exception("Erro: $e");
    }
  }
}
