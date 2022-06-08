import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/presentation/pages/settings/Utils/components.dart';

AppBar settingsAccountAppBar() {
  return AppBar(
    backgroundColor: backgroundPrimary1,
    toolbarHeight: 75,
    automaticallyImplyLeading: false,
    leading: const Icon(Icons.settings, size: 36.0),
    title: const Text("Account Settings", style: TextStyle(fontSize: 24.0)),
  );
}

class SettingsAccount extends StatelessWidget {
  const SettingsAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: settingsAccountAppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 48.0),
            SettingsButton(
              icon: Icons.account_circle,
              text: "Change Username",
              onTap: () {
                Navigator.pushNamed(context, settingsAccountUsername);
              },
            ),
            SettingsButton(
              icon: Icons.phone,
              text: "Change Phone Number",
              onTap: () {
                Navigator.pushNamed(context, settingsAccountPhoneNumber);
              },
            ),
            SettingsButton(
              icon: Icons.key,
              text: "Change Password",
              onTap: () {
                Navigator.pushNamed(context, settingsAccountPassword);
              },
            ),
            SettingsButton(
              icon: Icons.calendar_month,
              text: "Change Date of Birth",
              onTap: () {
                Navigator.pushNamed(context, settingsAccountDateOfBirth);
              },
            ),
            SettingsButton(
              icon: Icons.delete,
              text: "Delete Account",
              onTap: () {},
              backgroundColor: Colors.red[400]!,
            ),
          ],
        ),
      ),
    );
  }
}
