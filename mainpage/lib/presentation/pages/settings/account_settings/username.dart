import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAccountChangeUsername extends StatefulWidget {
  const SettingsAccountChangeUsername({Key? key}) : super(key: key);

  @override
  State<SettingsAccountChangeUsername> createState() =>
      _SettingsAccountChangeUsernameState();
}

class _SettingsAccountChangeUsernameState
    extends State<SettingsAccountChangeUsername> {
  late bool inputError = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: settingsAccountAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              "Change Username",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
            child: Text(
              'New Username',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (value) {
                if (inputError) {
                  setState(() {
                    inputError = false;
                  });
                }
              },
              controller: controller,
              key: const Key('New Username'),
              decoration: InputDecoration(
                errorText: inputError ? "Username is invalid" : null,
                hintText: 'username...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              textInputAction: TextInputAction.send,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                final newValue = controller.text;

                if (newValue.isEmpty) {
                  setState(() {
                    inputError = true;
                  });
                  return;
                }

                final prefs = await SharedPreferences.getInstance();
                final data = json.decode(prefs.getString("data")!);
                final email = data["email"];

                final docRefs = db.collection("users").doc(email);
                docRefs.update({"username": newValue}).then((value) {
                  print('username updated');
                }, onError: (e) {
                  print(e);
                });

                const snackBar = SnackBar(
                  content: Text("username updated"),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            },
            child: Text('Submit', style: button),
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shadowColor: Colors.black,
              primary: backgroundPrimary1,
              minimumSize: const Size(125, 40),
            ),
          ),
        ],
      ),
    );
  }
}
