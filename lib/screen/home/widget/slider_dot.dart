import 'package:flutter/material.dart';
import 'package:usluge_client/constant.dart';

class SliderDot extends StatelessWidget {
  const SliderDot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: mPrimaryColor,
                  borderRadius: BorderRadius.circular(50),
                )),
            Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: mPrimaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50),
                )),
            Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: mPrimaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50),
                ))
          ],
        ));
  }
}
