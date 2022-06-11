import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAccountChangeUsername extends StatelessWidget {
  const SettingsAccountChangeUsername({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    TextEditingController controller = TextEditingController();

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
              onChanged: (value) async {},
              controller: controller,
              key: const Key('New Username'),
              decoration: InputDecoration(
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
              final newValue = controller.text;
              final prefs = await SharedPreferences.getInstance();
              final data = json.decode(prefs.getString("data")!);
              final email = data["email"];

              final docRefs = db.collection("users").doc(email);
              docRefs.update({"username": newValue}).then((value) {
                print('username updated');
              }, onError: (e) {
                print(e);
              });

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
