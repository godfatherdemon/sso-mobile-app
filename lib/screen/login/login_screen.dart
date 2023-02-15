import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:usluge_client/constant.dart';
import 'package:usluge_client/screen/login/widget/login_button.dart';
import 'package:usluge_client/screen/login/widget/login_form.dart';
import 'package:usluge_client/screen/login/widget/welcome_back.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const WelcomeBack(),
              const LoginForm(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: mPrimaryColor),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const LoginButton(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                              text: "Register",
                              style: TextStyle(
                                color: mPrimaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                })
                        ]),
                  )),
            ]));
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: mBackgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      title: Text("Login",
          style: TextStyle(
            color: mPrimaryColor,
          )),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ));
}
