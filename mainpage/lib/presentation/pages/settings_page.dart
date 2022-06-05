import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
        children: const <Widget>[
          SettingsButton(icon: Icons.language, text: "Language"),
          SettingsButton(icon: Icons.account_circle, text: "Change Account"),
          SettingsButton(icon: Icons.location_on, text: "Location Settings"),
          SettingsButton(icon: Icons.calendar_month, text: "Schedule"),
          SettingsButton(icon: Icons.brush, text: "Theme"),
          SettingsButton(icon: Icons.logout, text: "Log Out"),
        ],
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          color: backgroundPrimary1,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 12.0),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
