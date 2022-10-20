import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import '../../../core/generics/resource.dart';
import '../../../core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final _hive = Hive.box<String>('credentials');

  @observable
  String email = '';

  @action
  void changeEmail(String newValue) => email = newValue;

  @observable
  String password = '';

  @action
  void changePassword(String newValue) => password = newValue;

  @observable
  Resource<UserModel, String> user = Resource.loading();

  @observable
  bool isPasswordVisible = false;

  @observable
  bool isButtonAtLoadingStatus = false;

  @action
  void setButtonToLoadingStatus() => isButtonAtLoadingStatus = true;

  @action
  void changePasswordVisibility() => isPasswordVisible = !isPasswordVisible;

  @computed
  bool get areCredentialsValid => isEmailValid && isPasswordValid;

  @action
  Future<Resource<UserModel, String>> loginUser() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .get();
      final currentUser = UserModel.fromMap(document.data()!);
      await _hive.put("id", currentUser.id!);
      return Resource.success(data: currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Resource.failed(error: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Resource.failed(error: 'Wrong password provided for that user.');
      } else {
        return Resource.failed(error: 'Error, please try again!');
      }
    }
  }

  @computed
  bool get isEmailValid =>
      email.isNotEmpty && email.contains('@') && email.contains(".com");

  @computed
  bool get isPasswordValid => password.length >= 6 && password.length <= 12;


}
