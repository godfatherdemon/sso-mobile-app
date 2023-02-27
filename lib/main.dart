import 'dart:io';

import 'package:flutter/material.dart';
import 'package:usluge_client/constant.dart';
import 'package:usluge_client/screen/login/login_screen.dart';
import 'package:usluge_client/screen/main/main_screen.dart';
import 'package:usluge_client/screen/splash/splash_screen.dart';

// An implementation of the HttpClient interface
class MyHttpClient implements HttpClient {
  MyHttpClient(SecurityContext? c);

  @override
  noSuchMethod(Invocation invocation) {
    // your implementation here
  }
}

void main() {
  HttpOverrides.runZoned(() {
    // Operations will use MyHttpClient instead of the real HttpClient
    // implementation whenever HttpClient is used.
  }, createHttpClient: (SecurityContext? c) => MyHttpClient(c));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usluge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
