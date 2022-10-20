import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:safesign_app/core/generics/resource.dart';
import 'package:safesign_app/core/models/user_model.dart';
import '../../../core/models/user_model_keys.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  @observable
  String firstName = '';
  @action
  void changeFirstName(String newValue) => firstName = newValue;

  @computed
  bool get isFirstNameValid => firstName.isNotEmpty;

  @observable
  String lastName = '';
  @action
  void changeLastName(String newValue) => lastName = newValue;

  @computed
  bool get isFirstLastValid => lastName.isNotEmpty;

  @observable
  String pin = '';
  @action
  void changePin(String newValue) => pin = newValue;

  @computed
  bool get isIdValid => pin.isNotEmpty && pin.length == 4;

  @observable
  String email = '';

  @action
  void changeEmail(String newValue) => email = newValue;

  @computed
  bool get isEmailValid => email.contains('@') && email.contains('.com');

  @observable
  String password = '';

  @action
  void changePassword(String newValue) => password = newValue;

  @observable
  bool isPasswordVisible = false;

  @action
  void changePasswordVisibility() => isPasswordVisible = !isPasswordVisible;

  @computed
  bool get isPasswordValid => password.length >= 6 && password.length <= 12;

  @observable
  String passwordConfirmation = '';

  @action
  void changePasswordConfirmation(String newValue) =>
      passwordConfirmation = newValue;

  @computed
  bool get isPasswordConfirmationValid => passwordConfirmation == password;

  @computed
  bool get allCredentialIsValid =>
      isPasswordValid && isPasswordConfirmationValid;

  @observable
  bool isButtonAtLoadingStatus = false;

  @action
  void setButtonToLoadingStatus() => isButtonAtLoadingStatus = true;

  @action
  Future<Resource<UserModel, String>> registerUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        UserModelKeys.id: credential.user!.uid,
        UserModelKeys.email: email,
        UserModelKeys.firstName: firstName,
        UserModelKeys.lastName: lastName,
        UserModelKeys.pin: pin,
      });
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .get();
      final currentUser = UserModel.fromMap(document.data()!);

      return Resource.success(data: currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Resource.failed(error: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        return Resource.failed(
            error: 'The account already exists for that email.');
      } else {
        return Resource.failed(error: "Error, try again");
      }
    }
  }

  @observable
  String userPhoneNumber = '';

  @observable
  String verificationIdReceived = '';

  @action
  void changePhoneNumber(String newNumber) => userPhoneNumber = newNumber;


  // @action
  // Future<void> verifyNumber() async {
    
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: userPhoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential).then((value) {
  //         print("You are logged in Successfuly");
  //       });
  //     },
  //     verificationFailed: (FirebaseException exception) {
  //       if (exception.code == 'invalid-phone-number') ;
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       verificationIdReceived = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {

  //     },
  //   );
  // }
}
