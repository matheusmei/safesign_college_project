import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:safesign_app/controller/register/register_controller.dart';
import 'package:safesign_app/core/helpers/resource.dart';
import 'package:safesign_app/ui/components/main_buttom.dart';
import 'package:safesign_app/ui/components/main_textfield.dart';
import 'package:safesign_app/ui/components/return_button.dart';
import 'package:safesign_app/ui/components/theme/colors_app.dart';
import 'package:safesign_app/ui/components/theme/fonts_app.dart';
import 'package:safesign_app/ui/home/home_page.dart';
import 'package:safesign_app/ui/login/components/custom_error_dialog.dart';


class RegisterPage extends StatelessWidget {
  final _controller = RegisterController();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.appDarkGrey,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ReturnButton(),
                      Expanded(
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'image/NewLogoSafeSign.png',
                            height: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: FontsApp.mainFontTitle32SemiBold.copyWith(
                              color: ColorsApp.appLightGrey,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Observer(builder: (_) {
                                return Expanded(
                                  child: MainTextField(
                                    onChanged: _controller.changeFirstName,
                                    labelText: 'First Name',
                                    choosedIcon: Icon(
                                      Icons.account_circle_rounded,
                                      color: ColorsApp.appBlue,
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(
                                width: 10,
                              ),
                              Observer(builder: (_) {
                                return Expanded(
                                  child: MainTextField(
                                    onChanged: _controller.changeLastName,
                                    labelText: 'Last Name',
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Observer(builder: (_) {
                            return MainTextField(
                              keyboardType: TextInputType.number,
                              onChanged: _controller.changePin,
                              labelText: 'Pin',
                              maxLength: 4,
                              choosedIcon: Icon(
                                Icons.key_rounded,
                                color: ColorsApp.appBlue,
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 16,
                          ),
                          Observer(builder: (_) {
                            return MainTextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: _controller.changeEmail,
                              labelText: 'Email',
                              choosedIcon: Icon(
                                Icons.mail_rounded,
                                color: ColorsApp.appBlue,
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 16,
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
                                onPressed: _controller.changePasswordVisibility,
                              ),
                              labelText: 'Password',
                              choosedIcon: Icon(
                                Icons.lock_rounded,
                                color: ColorsApp.appBlue,
                              ),
                              isObscure: !_controller.isPasswordVisible,
                            );
                          }),
                          const SizedBox(
                            height: 16,
                          ),
                          Observer(builder: (_) {
                            return MainTextField(
                              onChanged: _controller.changePasswordConfirmation,
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
                                  onPressed:
                                      _controller.changePasswordVisibility),
                              labelText: 'Confirm Password',
                              choosedIcon: Icon(
                                Icons.lock_rounded,
                                color: ColorsApp.appBlue,
                              ),
                              isObscure: !_controller.isPasswordVisible,
                            );
                          }),
                          const SizedBox(
                            height: 16,
                          ),             
                          ],
                      ),
                      Observer(builder: (_) {
                        bool isLoading = _controller.isButtonAtLoadingStatus;
                        return MainButtom(
                          onPressed: _controller.allCredentialIsValid
                              ? () async {
                                  _controller.setButtonToLoadingStatus();
                                  final resource =
                                      await _controller.registerUser();
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
                                   
                                    await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(user: resource.data!),
                                      ),
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
                                  _controller.allCredentialIsValid
                                      ? "Register"
                                      : "Invalid Inputs",
                                  style: FontsApp.mainFontText24.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorsApp.appLightGrey),
                                ),
                        );
                      })
                    ],
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
