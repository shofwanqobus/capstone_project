import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mainpage/presentation/pages/settings/Utils/components.dart';
import 'package:mainpage/presentation/provider/database_provider.dart';
import 'package:mainpage/presentation/provider/favorited_database_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

AppBar settingsAppBar() {
  return AppBar(
    backgroundColor: backgroundPrimary1,
    toolbarHeight: 75,
    automaticallyImplyLeading: false,
    leading: const Icon(Icons.settings, size: 36.0),
    title: const Text("Settings", style: TextStyle(fontSize: 24.0)),
  );
}

final _auth = FirebaseAuth.instance;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(),
      backgroundColor: backgroundPrimary2,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) =>
                FavoriteDatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
        ],
        child: userSettingsBody(context),
      ),
    );
  }
}

Widget userSettingsBody(BuildContext context) {
  Future<void> _confirmSignOut() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Confirmation")),
          content: SingleChildScrollView(
            child: Column(
              children: const [
                Text("Sign out?"),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[400],
              ),
              child: const Text("Confirm"),
              onPressed: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove("data");

                  await _auth.signOut();

                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: backgroundPrimary1,
              ),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
            final _isSignedGoogle =
                _auth.currentUser!.providerData[0].providerId == "google.com";
            if (_isSignedGoogle) return;
            Navigator.pushNamed(context, settingsChangeAccount);
          },
          backgroundColor:
              _auth.currentUser!.providerData[0].providerId == "google.com"
                  ? Colors.black54
                  : backgroundPrimary1,
        ),
        SettingsButton(
          icon: Icons.manage_accounts_rounded,
          text: "Account Settings",
          onTap: () {
            final _isSignedGoogle =
                _auth.currentUser!.providerData[0].providerId == "google.com";
            if (_isSignedGoogle) return;
            Navigator.pushNamed(context, settingsPasswordConfirmation);
          },
          backgroundColor:
              _auth.currentUser!.providerData[0].providerId == "google.com"
                  ? Colors.black54
                  : backgroundPrimary1,
        ),
        Consumer<FavoriteDatabaseProvider>(
          builder: ((context, value, child) {
            return SettingsButton(
              icon: Icons.logout,
              text: "Log Out",
              backgroundColor: Colors.red[400]!,
              onTap: () async {
                await _confirmSignOut();
                return false;
              },
            );
          }),
        ),
      ],
    ),
  );
}
