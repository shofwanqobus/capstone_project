import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

enum ThemeController { light, dark }

class SettingsTheme extends StatefulWidget {
  const SettingsTheme({Key? key}) : super(key: key);

  @override
  State<SettingsTheme> createState() => _LanguageState();
}

class _LanguageState extends State<SettingsTheme> {
  ThemeController? _themeController;

  @override
  void initState() {
    super.initState();
    _themeController = ThemeController.dark;
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
              "SettingsTheme",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: const Text("Light"),
            leading: Radio<ThemeController>(
              value: ThemeController.light,
              groupValue: _themeController,
              onChanged: (ThemeController? value) {
                setState(() {
                  _themeController = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Dark"),
            leading: Radio<ThemeController>(
              value: ThemeController.dark,
              groupValue: _themeController,
              onChanged: (ThemeController? value) {
                setState(() {
                  _themeController = value;
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
