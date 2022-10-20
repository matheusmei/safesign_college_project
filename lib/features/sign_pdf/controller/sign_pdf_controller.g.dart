// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_pdf_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignPdfController on _SignPdfControllerBase, Store {
  Computed<bool>? _$isIdValidComputed;

  @override
  bool get isIdValid =>
      (_$isIdValidComputed ??= Computed<bool>(() => super.isIdValid,
              name: '_SignPdfControllerBase.isIdValid'))
          .value;
  Computed<bool>? _$isTypedPinValidComputed;

  @override
  bool get isTypedPinValid =>
      (_$isTypedPinValidComputed ??= Computed<bool>(() => super.isTypedPinValid,
              name: '_SignPdfControllerBase.isTypedPinValid'))
          .value;

  late final _$currentDocAtom =
      Atom(name: '_SignPdfControllerBase.currentDoc', context: context);

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

  late final _$pinAtom =
      Atom(name: '_SignPdfControllerBase.pin', context: context);

  @override
  String get pin {
    _$pinAtom.reportRead();
    return super.pin;
  }

  @override
  set pin(String value) {
    _$pinAtom.reportWrite(value, super.pin, () {
      super.pin = value;
    });
  }

  late final _$currentPinAtom =
      Atom(name: '_SignPdfControllerBase.currentPin', context: context);

  @override
  String get currentPin {
    _$currentPinAtom.reportRead();
    return super.currentPin;
  }

  @override
  set currentPin(String value) {
    _$currentPinAtom.reportWrite(value, super.currentPin, () {
      super.currentPin = value;
    });
  }

  late final _$getCurrentPinAsyncAction =
      AsyncAction('_SignPdfControllerBase.getCurrentPin', context: context);

  @override
  Future<void> getCurrentPin() {
    return _$getCurrentPinAsyncAction.run(() => super.getCurrentPin());
  }

  late final _$readImageDataAsyncAction =
      AsyncAction('_SignPdfControllerBase.readImageData', context: context);

  @override
  Future<Uint8List> readImageData(String name) {
    return _$readImageDataAsyncAction.run(() => super.readImageData(name));
  }

  late final _$signDocumentAsyncAction =
      AsyncAction('_SignPdfControllerBase.signDocument', context: context);

  @override
  Future<void> signDocument() {
    return _$signDocumentAsyncAction.run(() => super.signDocument());
  }

  late final _$_SignPdfControllerBaseActionController =
      ActionController(name: '_SignPdfControllerBase', context: context);

  @override
  void changeCurrentDoc(DocModel newValue) {
    final _$actionInfo = _$_SignPdfControllerBaseActionController.startAction(
        name: '_SignPdfControllerBase.changeCurrentDoc');
    try {
      return super.changeCurrentDoc(newValue);
    } finally {
      _$_SignPdfControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePin(String newValue) {
    final _$actionInfo = _$_SignPdfControllerBaseActionController.startAction(
        name: '_SignPdfControllerBase.changePin');
    try {
      return super.changePin(newValue);
    } finally {
      _$_SignPdfControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentDoc: ${currentDoc},
pin: ${pin},
currentPin: ${currentPin},
isIdValid: ${isIdValid},
isTypedPinValid: ${isTypedPinValid}
    ''';
  }
}
