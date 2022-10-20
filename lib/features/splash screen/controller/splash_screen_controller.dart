import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safesign_app/core/models/user_model.dart';
import 'package:safesign_app/features/home/view/home_page.dart';
import 'package:safesign_app/features/login/view/login_page.dart';

class SplashScreenController {
  Future checkIfUserIsLoggedIn(BuildContext mycontext) async {
    await Future.delayed(
      const Duration(seconds: 4),
    );
    UserModel uid = UserModel();

    FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {

      
      if (currentUser != null) {
        uid.id = currentUser.uid;
        Navigator.push(
          mycontext,
          MaterialPageRoute(
            builder: (context) => HomePage(user: uid),
          ),
        );
        return;
      } else {
        Navigator.pushReplacement(
          mycontext,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }
}
