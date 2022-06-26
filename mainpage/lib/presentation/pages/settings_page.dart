import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        Consumer<FavoriteDatabaseProvider>(
          builder: ((context, value, child) {
            return SettingsButton(
              icon: Icons.logout,
              text: "Log Out",
              backgroundColor: Colors.red[400]!,
              onTap: () async {
                // TODO: Caching Data, check version by hashing

                /* print(DateTime.now().toIso8601String());
                var text = "";
                var chars =
                    "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

                for (var i = 0; i < 128; i++) {
                  var selected = chars[Random().nextInt(chars.length)];

                  text += selected;
                }

                print(text); */

                final prefs = await SharedPreferences.getInstance();
                prefs.remove("data");

                await _auth.signOut();
                Navigator.pop(context);
              },
            );
          }),
        ),
      ],
    ),
  );
}
