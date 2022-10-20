import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:safesign_app/core/theme/colors_app.dart';
import 'package:safesign_app/core/theme/fonts_app.dart';
import 'package:safesign_app/core/widgets/main_buttom.dart';
import 'package:safesign_app/core/widgets/main_textfield.dart';
import 'package:safesign_app/features/login/view/widgets/custom_error_dialog.dart';
import 'package:safesign_app/features/register/view/register_page.dart';
import '../../../core/generics/resource.dart';
import '../../home/view/home_page.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final _controller = LoginController();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.appDarkGrey,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: Image.asset(
                    'image/NewLogoSafeSign.png',
                    height: 150,
                    width: 250,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log In",
                      style: FontsApp.mainFontTitle32SemiBold.copyWith(
                        color: ColorsApp.appLightGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return MainTextField(
                        onChanged: _controller.changeEmail,
                        labelText: "Email",
                        choosedIcon: Icon(
                          Icons.mail_rounded,
                          color: ColorsApp.appBlue,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Observer(builder: (_) {
                      return MainTextField(
                        onChanged: _controller.changePassword,
                        suffixIcon: IconButton(
                            icon: _controller.isPasswordVisible
                                ? Icon(
                                    Icons.visibility,
                                    color: ColorsApp.appBlue,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: ColorsApp.appBlue,
                                  ),
                            onPressed: _controller.changePasswordVisibility),
                        labelText: "Password",
                        choosedIcon: Icon(
                          Icons.lock_rounded,
                          color: ColorsApp.appBlue,
                        ),
                        isObscure: !_controller.isPasswordVisible,
                      );
                    }),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: FontsApp.mainFontText16.copyWith(
                              color: ColorsApp.appLightGrey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            "Sign Up",
                            style: FontsApp.mainFontText16.copyWith(
                              color: ColorsApp.appBlue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(
                      builder: (_) {
                        bool isLoading = _controller.isButtonAtLoadingStatus;
                        return MainButtom(
                          onPressed: _controller.areCredentialsValid
                              ? () async {
                                  _controller.setButtonToLoadingStatus();
                                  final resource =
                                      await _controller.loginUser();
                                  if (resource.hasError) {
                                    await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomErrorDialog(
                                                errorMessage:
                                                    resource.error.toString(),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              );
                                            })
                                        .then((_) => _controller
                                            .isButtonAtLoadingStatus = false);
                                  }
                                  if (resource.status == Status.success) {
                                    // ignore: use_build_context_synchronously
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePage(user: resource.data!)),
                                    );
                                  }
                                }
                              : null,
                          child: isLoading
                              ? Lottie.asset(
                                  'image/loadinganimation.json',
                                  height: 64,
                                  width: 64,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fill,
                                )
                              : Text(
                                  _controller.areCredentialsValid
                                      ? "Log In"
                                      : "Invalid Credentials",
                                  style: FontsApp.mainFontText24.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorsApp.appLightGrey),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
