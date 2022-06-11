import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/presentation/pages/settings/Utils/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final _auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;

    Future<void> _confirmDeleteAccount() async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text("Are you sure?"),
                  Text("This action cannot be reversed!"),
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
                    await _auth.currentUser!.delete();

                    final prefs = await SharedPreferences.getInstance();
                    final data = json.decode(prefs.getString("data")!);
                    final email = data["email"];

                    await db.collection("users").doc(email).delete();

                    prefs.remove("data");

                    Navigator.pop(context);
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

    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: settingsAccountAppBar(),
      body: SingleChildScrollView(
        child: Center(
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
                onTap: () async {
                  _confirmDeleteAccount();
                },
                backgroundColor: Colors.red[400]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
