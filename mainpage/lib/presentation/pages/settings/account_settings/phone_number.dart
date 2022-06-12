import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAccountChangePhoneNumber extends StatefulWidget {
  const SettingsAccountChangePhoneNumber({Key? key}) : super(key: key);

  @override
  State<SettingsAccountChangePhoneNumber> createState() =>
      _SettingsAccountChangePhoneNumberState();
}

class _SettingsAccountChangePhoneNumberState
    extends State<SettingsAccountChangePhoneNumber> {
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
              "Change Phone Number",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
            child: Text(
              'Phone Number',
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
              key: const Key('Phone Number'),
              decoration: InputDecoration(
                errorText: inputError ? "Phone Number is invalid" : null,
                hintText: '08xx...',
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
              docRefs.update({"phone_number": newValue}).then((value) {
                print('Phone number updated');
              }, onError: (e) {
                print(e);
              });

              const snackBar = SnackBar(
                content: Text("Phone Number updated"),
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
