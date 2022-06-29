import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

class SettingsSchedule extends StatefulWidget {
  const SettingsSchedule({Key? key}) : super(key: key);

  @override
  State<SettingsSchedule> createState() => _LanguageState();
}

class _LanguageState extends State<SettingsSchedule> {
  late bool _notification;

  @override
  void initState() {
    super.initState();
    _notification = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(),
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
