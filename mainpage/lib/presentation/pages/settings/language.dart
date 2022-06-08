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
      appBar: homeAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              "Language",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: const Text("Indonesia"),
            leading: Radio<LanguageController>(
              value: LanguageController.indonesia,
              groupValue: _languageController,
              onChanged: (LanguageController? value) {
                setState(() {
                  _languageController = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("English"),
            leading: Radio<LanguageController>(
              value: LanguageController.english,
              groupValue: _languageController,
              onChanged: (LanguageController? value) {
                setState(() {
                  _languageController = value;
                });
              },
            ),
          ),
        ],
      ),
      backgroundColor: backgroundPrimary2,
    );
  }
}
