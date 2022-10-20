// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_status_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DocumentStatusController on _DocumentStatusControllerBase, Store {
  Computed<bool>? _$isDocumentAvailableComputed;

  @override
  bool get isDocumentAvailable => (_$isDocumentAvailableComputed ??=
          Computed<bool>(() => super.isDocumentAvailable,
              name: '_DocumentStatusControllerBase.isDocumentAvailable'))
      .value;

  late final _$currentDocAtom =
      Atom(name: '_DocumentStatusControllerBase.currentDoc', context: context);

  @override
  DocModel get currentDoc {
    _$currentDocAtom.reportRead();
    return super.currentDoc;
  }

  @override
  set currentDoc(DocModel value) {
    _$currentDocAtom.reportWrite(value, super.currentDoc, () {
      super.currentDoc = value;
    });
  }

  late final _$pendingToSignListAtom = Atom(
      name: '_DocumentStatusControllerBase.pendingToSignList',
      context: context);

  @override
  ObservableList<UserModel> get pendingToSignList {
    _$pendingToSignListAtom.reportRead();
    return super.pendingToSignList;
  }

  @override
  set pendingToSignList(ObservableList<UserModel> value) {
    _$pendingToSignListAtom.reportWrite(value, super.pendingToSignList, () {
      super.pendingToSignList = value;
    });
  }

  late final _$peopleInvolvedListAtom = Atom(
      name: '_DocumentStatusControllerBase.peopleInvolvedList',
      context: context);

  @override
  ObservableList<UserModel> get peopleInvolvedList {
    _$peopleInvolvedListAtom.reportRead();
    return super.peopleInvolvedList;
  }

  @override
  set peopleInvolvedList(ObservableList<UserModel> value) {
    _$peopleInvolvedListAtom.reportWrite(value, super.peopleInvolvedList, () {
      super.peopleInvolvedList = value;
    });
  }

  late final _$getDocInfoListAsyncAction = AsyncAction(
      '_DocumentStatusControllerBase.getDocInfoList',
      context: context);

  @override
  Future<void> getDocInfoList() {
    return _$getDocInfoListAsyncAction.run(() => super.getDocInfoList());
  }

  late final _$downloadPdfAsyncAction = AsyncAction(
      '_DocumentStatusControllerBase.downloadPdf',
      context: context);

  @override
  Future<void> downloadPdf() {
    return _$downloadPdfAsyncAction.run(() => super.downloadPdf());
  }

  late final _$_DocumentStatusControllerBaseActionController =
      ActionController(name: '_DocumentStatusControllerBase', context: context);

  @override
  void changeCurrentDoc(DocModel newValue) {
    final _$actionInfo = _$_DocumentStatusControllerBaseActionController
        .startAction(name: '_DocumentStatusControllerBase.changeCurrentDoc');
    try {
      return super.changeCurrentDoc(newValue);
    } finally {
      _$_DocumentStatusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentDoc: ${currentDoc},
pendingToSignList: ${pendingToSignList},
peopleInvolvedList: ${peopleInvolvedList},
isDocumentAvailable: ${isDocumentAvailable}
    ''';
  }
}
