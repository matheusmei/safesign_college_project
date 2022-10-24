// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$firstNameAtom =
      Atom(name: '_HomeControllerBase.firstName', context: context);

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_HomeControllerBase.lastName', context: context);

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$userIdFireBaseAtom =
      Atom(name: '_HomeControllerBase.userIdFireBase', context: context);

  @override
  String get userIdFireBase {
    _$userIdFireBaseAtom.reportRead();
    return super.userIdFireBase;
  }

  @override
  set userIdFireBase(String value) {
    _$userIdFireBaseAtom.reportWrite(value, super.userIdFireBase, () {
      super.userIdFireBase = value;
    });
  }

  late final _$documentstoSignLengthAtom =
      Atom(name: '_HomeControllerBase.documentstoSignLength', context: context);

  @override
  int get documentstoSignLength {
    _$documentstoSignLengthAtom.reportRead();
    return super.documentstoSignLength;
  }

  @override
  set documentstoSignLength(int value) {
    _$documentstoSignLengthAtom.reportWrite(value, super.documentstoSignLength,
        () {
      super.documentstoSignLength = value;
    });
  }

  late final _$availableDocumentsLengthAtom = Atom(
      name: '_HomeControllerBase.availableDocumentsLength', context: context);

  @override
  int get availableDocumentsLength {
    _$availableDocumentsLengthAtom.reportRead();
    return super.availableDocumentsLength;
  }

  @override
  set availableDocumentsLength(int value) {
    _$availableDocumentsLengthAtom
        .reportWrite(value, super.availableDocumentsLength, () {
      super.availableDocumentsLength = value;
    });
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('_HomeControllerBase.getUserData', context: context);

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$getDocumentstoSignLengthAsyncAction = AsyncAction(
      '_HomeControllerBase.getDocumentstoSignLength',
      context: context);

  @override
  Future<void> getDocumentstoSignLength() {
    return _$getDocumentstoSignLengthAsyncAction
        .run(() => super.getDocumentstoSignLength());
  }

  late final _$getAvailableDocumentsLengthAsyncAction = AsyncAction(
      '_HomeControllerBase.getAvailableDocumentsLength',
      context: context);

  @override
  Future<void> getAvailableDocumentsLength() {
    return _$getAvailableDocumentsLengthAsyncAction
        .run(() => super.getAvailableDocumentsLength());
  }

  @override
  String toString() {
    return '''
firstName: ${firstName},
lastName: ${lastName},
userIdFireBase: ${userIdFireBase},
documentstoSignLength: ${documentstoSignLength},
availableDocumentsLength: ${availableDocumentsLength}
    ''';
  }
}
