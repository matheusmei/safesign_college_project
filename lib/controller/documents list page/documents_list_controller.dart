import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:safesign_app/core/models/doc_model.dart';
import 'package:safesign_app/core/models/user_model_keys.dart';
part 'documents_list_controller.g.dart';

class DocumentsListController = _DocumentsListControllerBase
    with _$DocumentsListController;

abstract class _DocumentsListControllerBase with Store {
  final user = FirebaseAuth.instance.currentUser!;

  @observable
  ObservableList<DocModel> generalDocmentsList = <DocModel>[].asObservable();

  @observable
  ObservableList<DocModel> documentsToSign = <DocModel>[].asObservable();

  @observable
  ObservableList<DocModel> availableDocuments = <DocModel>[].asObservable();

  @action
  Future<void> fetchDocumentByStatus(String documentType) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid).collection(documentType)
        .get();

    final doc =
        querySnapshot.docs.map((e) => DocModel.fromMap(e.data())).toList();
        
    switch (documentType) {
      case UserModelKeys.documentsToSign:
        documentsToSign = doc.asObservable();
        generalDocmentsList = documentsToSign;
        break;
      case UserModelKeys.availableDocuments:
        availableDocuments = doc.asObservable();
        generalDocmentsList = availableDocuments;
        break;
      default:
        break;
    }
  }
}
