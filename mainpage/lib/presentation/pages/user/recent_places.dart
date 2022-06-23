import 'package:core/core.dart';
import 'package:flutter/material.dart';

class UserRecentPlaces extends StatelessWidget {
  const UserRecentPlaces({Key? key}) : super(key: key);

  AppBar recent() {
    return AppBar(
      backgroundColor: backgroundPrimary1,
      toolbarHeight: 75,
      title: Text('Recent', style: button),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: recent(),
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
