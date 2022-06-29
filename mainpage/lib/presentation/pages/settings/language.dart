import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

enum LanguageController { english, indonesia }

class SettingsLanguage extends StatefulWidget {
  const SettingsLanguage({Key? key}) : super(key: key);

  @override
  State<SettingsLanguage> createState() => _LanguageState();
}

class _LanguageState extends State<SettingsLanguage> {
  LanguageController? _languageController;

  @override
  void initState() {
    super.initState();
    _languageController = LanguageController.english;
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
