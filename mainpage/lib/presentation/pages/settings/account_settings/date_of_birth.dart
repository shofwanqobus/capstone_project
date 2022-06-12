import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAccountChangeDateOfBirth extends StatefulWidget {
  const SettingsAccountChangeDateOfBirth({Key? key}) : super(key: key);

  @override
  State<SettingsAccountChangeDateOfBirth> createState() =>
      _SettingsAccountChangeDateOfBirthState();
}

class _SettingsAccountChangeDateOfBirthState
    extends State<SettingsAccountChangeDateOfBirth> {
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
              "Change Date of Birth",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
            child: Text(
              'Date of Birth',
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
              key: const Key('Date of Birth'),
              decoration: InputDecoration(
                errorText: inputError ? "Date is invalid" : null,
                hintText: '20 January 2004',
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
              docRefs.update({"date_of_birth": newValue}).then((value) {
                print('Date of birth updated');
              }, onError: (e) {
                print(e);
              });

              const snackBar = SnackBar(
                content: Text("Date of Birth updated"),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Navigator.pop(context);
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
