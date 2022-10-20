import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import 'package:safesign_app/features/login/view/login_page.dart';

import '../../upload/view/widgets/custom_inform_dialog.dart';

class CustomDrawer extends StatelessWidget {
  final String firstName;
  final String lastName;
  const CustomDrawer({
    Key? key,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: ColorsApp.appDarkGrey.withOpacity(0.5),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 80,
                        color: ColorsApp.appBlue,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        firstName,
                        style: FontsApp.mainFontTitle32SemiBold.copyWith(
                          color: ColorsApp.appLightGrey,
                        ),
                      ),
                      Text(
                        lastName,
                        style: FontsApp.mainFontTitle32SemiBold.copyWith(
                          color: ColorsApp.appLightGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  InkWell(
                      child: Text(
                        "Logout",
                        style: FontsApp.mainFontText16.copyWith(
                          color: ColorsApp.appRed,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomInformDialog(
                              lottieUrl: 'image/logoutanimation.json',
                              errorMessage: "Really want to Logout?",
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
