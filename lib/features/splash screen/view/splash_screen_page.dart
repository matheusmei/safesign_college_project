import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:safesign_app/core/models/user_model.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/features/home/view/home_page.dart';
import 'package:safesign_app/features/login/view/login_page.dart';
import 'package:safesign_app/features/splash%20screen/controller/splash_screen_controller.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final _controller = SplashScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Observer(builder: (_) {
          _controller.checkIfUserIsLoggedIn(context);
          return Stack(
            children: [
              Lottie.asset("image/splashanimation.json"),
              Hero(
                tag: "logo",
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("image/logoSplash.png"),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
