import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safesign_app/core/models/doc_model.dart';
import 'package:safesign_app/core/models/doc_model_keys.dart';
import 'package:safesign_app/core/models/user_model_keys.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../core/models/user_model.dart';
part 'sign_pdf_controller.g.dart';

class SignPdfController = _SignPdfControllerBase with _$SignPdfController;

abstract class _SignPdfControllerBase with Store {
  final user = FirebaseAuth.instance.currentUser!;

  @observable
  DocModel currentDoc = DocModel();

  @action
  void changeCurrentDoc(DocModel newValue) => currentDoc = newValue;

  @observable
  String pin = "";

  @action
  void changePin(String newValue) => pin = newValue;

  @computed
  bool get isIdValid => pin.isNotEmpty && pin.length == 4;

  @observable
  String currentPin = "";

  @computed
  bool get isTypedPinValid => pin == currentPin;

  @action
  Future<void> getCurrentPin() async {
    final document = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    final currentUser = UserModel.fromMap(document.data()!);
    currentPin = currentUser.pin!;
  }

  @action
  Future<Uint8List> readImageData(String name) async {
    final data = await rootBundle.load("image/$name");
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @action
  Future<void> signDocument() async {
    Reference ref = await FirebaseStorage.instance
        .ref('files/${currentDoc.ownerId}/${currentDoc.id}.pdf');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}.pdf');
    await ref.writeToFile(file);
    final PdfDocument document = PdfDocument(
      inputBytes: File('${dir.path}/${ref.name}.pdf').readAsBytesSync(),
    );
    final PdfPage page = document.pages.add();
    page.graphics.drawString(
          'Document signed through SafeSign® in ${DateTime.now()}.',
          PdfStandardFont(PdfFontFamily.helvetica, 12),
          brush: PdfSolidBrush(
            PdfColor(0, 0, 0),
          ),
          bounds: const Rect.fromLTWH(0, 0, 500, 20),
        );
            page.graphics.drawString(
          'Certification Number: ${user.uid}${DateTime.now().toString()}.',
          PdfStandardFont(PdfFontFamily.helvetica, 12),
          brush: PdfSolidBrush(
            PdfColor(0, 0, 0),
          ),
          bounds: const Rect.fromLTWH(0, 30, 500, 20),
        );
    page.graphics.drawImage(PdfBitmap(await readImageData("certificationimage.png")), const Rect.fromLTWH(0, 80, 300, 80));
    final outputFile = await file.writeAsBytes(document.save());
    document.dispose();
    final File finalFile = outputFile;
    String firebaseRef = "files/${currentDoc.ownerId}/${currentDoc.id}.pdf";
    await FirebaseStorage.instance.ref(firebaseRef).putFile(finalFile);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentDoc.ownerId)
        .collection("files")
        .doc(currentDoc.id)
        .update({
      DocModelKeys.pendingToSign: FieldValue.arrayRemove([user.uid])
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection(UserModelKeys.documentsToSign)
        .doc(currentDoc.id)
        .delete();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection(UserModelKeys.availableDocuments)
        .doc(currentDoc.id)
        .set({
      "_id": currentDoc.id,
      "owner_id": currentDoc.ownerId,
      "url": currentDoc.url,
    });
  }
}
