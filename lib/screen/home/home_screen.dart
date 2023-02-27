import 'package:flutter/material.dart';
import 'package:usluge_client/constant.dart';
import 'package:usluge_client/screen/home/widget/login_and_register.dart';
import 'package:usluge_client/screen/home/widget/login_with_facebook.dart';
import 'package:usluge_client/screen/home/widget/slider_dot.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Image.asset('assets/images/usluge.png'),
      const SliderDot(),
      const SizedBox(
        height: 20,
      ),
      Text("Najbolje usluge na jednom mestu!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          )),
      const SizedBox(
        height: 60,
      ),
      const LoginAndRegister(),
      const LoginWithFacebook(),
    ]));
  }
}
