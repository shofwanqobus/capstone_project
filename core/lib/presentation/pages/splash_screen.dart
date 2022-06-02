import 'dart:async';
import 'package:core/core.dart';
import 'package:login/login.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Icon(
              Icons.airplanemode_active,
              size: 200,
              color: backgroundPrimary2,
            ),
          ),
          Center(
            child: Text(
              'Be Traveled',
              style: kHeading4,
            ),
          ),
        ],
      ),
    );
  }
}
