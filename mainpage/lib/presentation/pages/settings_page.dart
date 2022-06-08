import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/presentation/pages/settings/Utils/components.dart';

AppBar settingsAppBar() {
  return AppBar(
    backgroundColor: backgroundPrimary1,
    toolbarHeight: 75,
    automaticallyImplyLeading: false,
    leading: const Icon(Icons.settings, size: 36.0),
    title: const Text("Settings", style: TextStyle(fontSize: 24.0)),
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SettingsButton(
            icon: Icons.language,
            text: "Language",
            onTap: () {
              Navigator.pushNamed(context, settingsLanguage);
            },
          ),
          SettingsButton(
              icon: Icons.brush,
              text: "Theme",
              onTap: () {
                Navigator.pushNamed(context, settingsTheme);
              }),
          SettingsButton(
              icon: Icons.calendar_month,
              text: "Schedule",
              onTap: () {
                Navigator.pushNamed(context, settingsSchedule);
              }),
          SettingsButton(
            icon: Icons.account_circle,
            text: "Change Account",
            onTap: () {
              Navigator.pushNamed(context, settingsChangeAccount);
            },
          ),
          SettingsButton(
            icon: Icons.manage_accounts_rounded,
            text: "Account Settings",
            onTap: () {
              Navigator.pushNamed(context, settingsPasswordConfirmation);
            },
          ),
          SettingsButton(icon: Icons.logout, text: "Log Out", onTap: () {}),
        ],
      ),
    );
  }
}
