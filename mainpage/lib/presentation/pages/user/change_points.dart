import 'package:core/core.dart';
import 'package:flutter/material.dart';

class UserChangePoints extends StatelessWidget {
  const UserChangePoints({Key? key}) : super(key: key);

  AppBar changePoints() {
    return AppBar(
      backgroundColor: backgroundPrimary1,
      toolbarHeight: 75,
      title: Text('Change Points', style: button),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changePoints(),
      backgroundColor: backgroundPrimary2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.speaker, size: 75, color: black),
            const SizedBox(height: 5),
            Text('Coming Soon!', style: kHeading6),
          ],
        ),
      ),
    );
  }
}
