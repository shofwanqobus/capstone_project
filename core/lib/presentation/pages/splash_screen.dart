import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginChoice()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary1,
      body: Center(
        child: Image.asset('assets/be_traveled.png'),
      ),
    );
  }
}
