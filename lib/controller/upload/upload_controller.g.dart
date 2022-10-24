// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UploadController on _UploadControllerBase, Store {
  Computed<bool>? _$isDocumentNameValidComputed;

  @override
  bool get isDocumentNameValid => (_$isDocumentNameValidComputed ??=
          Computed<bool>(() => super.isDocumentNameValid,
              name: '_UploadControllerBase.isDocumentNameValid'))
      .value;
  Computed<bool>? _$isPeopleInvolvedValidComputed;

  @override
  bool get isPeopleInvolvedValid => (_$isPeopleInvolvedValidComputed ??=
          Computed<bool>(() => super.isPeopleInvolvedValid,
              name: '_UploadControllerBase.isPeopleInvolvedValid'))
      .value;
  Computed<bool>? _$areDocumentsInfoValidComputed;

  @override
  bool get areDocumentsInfoValid => (_$areDocumentsInfoValidComputed ??=
          Computed<bool>(() => super.areDocumentsInfoValid,
              name: '_UploadControllerBase.areDocumentsInfoValid'))
      .value;

  late final _$documentNameAtom =
      Atom(name: '_UploadControllerBase.documentName', context: context);

  @override
  String get documentName {
    _$documentNameAtom.reportRead();
    return super.documentName;
  }

  @override
  set documentName(String value) {
    _$documentNameAtom.reportWrite(value, super.documentName, () {
      super.documentName = value;
    });
  }

  late final _$isTileExpandedAtom =
      Atom(name: '_UploadControllerBase.isTileExpanded', context: context);

  @override
  bool get isTileExpanded {
    _$isTileExpandedAtom.reportRead();
    return super.isTileExpanded;
  }

  @override
  set isTileExpanded(bool value) {
    _$isTileExpandedAtom.reportWrite(value, super.isTileExpanded, () {
      super.isTileExpanded = value;
    });
  }

  late final _$userListAtom =
      Atom(name: '_UploadControllerBase.userList', context: context);

  @override
  ObservableList<UserModel> get userList {
    _$userListAtom.reportRead();
    return super.userList;
  }

  @override
  set userList(ObservableList<UserModel> value) {
    _$userListAtom.reportWrite(value, super.userList, () {
      super.userList = value;
    });
  }

  late final _$selectedUserListAtom =
      Atom(name: '_UploadControllerBase.selectedUserList', context: context);

  @override
  ObservableList<UserModel> get selectedUserList {
    _$selectedUserListAtom.reportRead();
    return super.selectedUserList;
  }

  @override
  set selectedUserList(ObservableList<UserModel> value) {
    _$selectedUserListAtom.reportWrite(value, super.selectedUserList, () {
      super.selectedUserList = value;
    });
  }

  late final _$isButtonAtLoadingStatusAtom = Atom(
      name: '_UploadControllerBase.isButtonAtLoadingStatus', context: context);

  @override
  bool get isButtonAtLoadingStatus {
    _$isButtonAtLoadingStatusAtom.reportRead();
    return super.isButtonAtLoadingStatus;
  }

  @override
  set isButtonAtLoadingStatus(bool value) {
    _$isButtonAtLoadingStatusAtom
        .reportWrite(value, super.isButtonAtLoadingStatus, () {
      super.isButtonAtLoadingStatus = value;
    });
  }

  late final _$selectedFileAtom =
      Atom(name: '_UploadControllerBase.selectedFile', context: context);

  @override
  File get selectedFile {
    _$selectedFileAtom.reportRead();
    return super.selectedFile;
  }

  @override
  set selectedFile(File value) {
    _$selectedFileAtom.reportWrite(value, super.selectedFile, () {
      super.selectedFile = value;
    });
  }

  late final _$getUserModelListAsyncAction =
      AsyncAction('_UploadControllerBase.getUserModelList', context: context);

  @override
  Future<List<UserModel>> getUserModelList() {
    return _$getUserModelListAsyncAction.run(() => super.getUserModelList());
  }

  late final _$pickPdfAsyncAction =
      AsyncAction('_UploadControllerBase.pickPdf', context: context);

  @override
  Future<void> pickPdf() {
    return _$pickPdfAsyncAction.run(() => super.pickPdf());
  }

  late final _$uploadPdfAsyncAction =
      AsyncAction('_UploadControllerBase.uploadPdf', context: context);

  @override
  Future<void> uploadPdf() {
    return _$uploadPdfAsyncAction.run(() => super.uploadPdf());
  }

  late final _$_UploadControllerBaseActionController =
      ActionController(name: '_UploadControllerBase', context: context);

  @override
  void changeDocumentName(String newValue) {
    final _$actionInfo = _$_UploadControllerBaseActionController.startAction(
        name: '_UploadControllerBase.changeDocumentName');
    try {
      return super.changeDocumentName(newValue);
    } finally {
      _$_UploadControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTileExpansion() {
    final _$actionInfo = _$_UploadControllerBaseActionController.startAction(
        name: '_UploadControllerBase.changeTileExpansion');
    try {
      return super.changeTileExpansion();
    } finally {
      _$_UploadControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addUserToSelectedList(UserModel selectedUserModel) {
    final _$actionInfo = _$_UploadControllerBaseActionController.startAction(
        name: '_UploadControllerBase.addUserToSelectedList');
    try {
      return super.addUserToSelectedList(selectedUserModel);
    } finally {
      _$_UploadControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeUserFromSelectedList(UserModel selectedUserModel) {
    final _$actionInfo = _$_UploadControllerBaseActionController.startAction(
        name: '_UploadControllerBase.removeUserFromSelectedList');
    try {
      return super.removeUserFromSelectedList(selectedUserModel);
    } finally {
      _$_UploadControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setButtonToLoadingStatus() {
    final _$actionInfo = _$_UploadControllerBaseActionController.startAction(
        name: '_UploadControllerBase.setButtonToLoadingStatus');
    try {
      return super.setButtonToLoadingStatus();
    } finally {
      _$_UploadControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
documentName: ${documentName},
isTileExpanded: ${isTileExpanded},
userList: ${userList},
selectedUserList: ${selectedUserList},
isButtonAtLoadingStatus: ${isButtonAtLoadingStatus},
selectedFile: ${selectedFile},
isDocumentNameValid: ${isDocumentNameValid},
isPeopleInvolvedValid: ${isPeopleInvolvedValid},
areDocumentsInfoValid: ${areDocumentsInfoValid}
    ''';
  }
}
