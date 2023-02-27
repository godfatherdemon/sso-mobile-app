import 'package:flutter/material.dart';
import 'package:usluge_client/constant.dart';
import 'package:usluge_client/screen/main/main_screen.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mPrimaryColor, // foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const MainScreen();
                    },
                  ));
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: const Text("Login",
                        style: TextStyle(
                          color: Colors.white,
                        ))),
              ),
            ),
          ],
        ));
  }
}
