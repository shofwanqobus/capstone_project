import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAccountChangePassword extends StatelessWidget {
  const SettingsAccountChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;

    TextEditingController controller = TextEditingController();
    TextEditingController confirmController = TextEditingController();

    return Scaffold(
      appBar: settingsAccountAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Center(
              child: Text(
                "Change Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
              child: Text(
                'New Password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                key: const Key('Password'),
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'password...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                textInputAction: TextInputAction.send,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
              child: Text(
                'Confirm New Password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                key: const Key('New Password'),
                controller: confirmController,
                decoration: InputDecoration(
                  hintText: 'password...',
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
                  final confirmValue = controller.text;

                  if (newValue != confirmValue) throw "Password does not match";
                  if (newValue.length < 6)
                    throw "Password must at least has 6 character";

                  final prefs = await SharedPreferences.getInstance();
                  final data = json.decode(prefs.getString("data")!);
                  final email = data["email"];

                  await _auth.currentUser!.updatePassword(newValue);

                  final docRefs = db.collection("users").doc(email);
                  docRefs.update({"password": newValue}).then((value) {
                    prefs.setString("passsword", newValue);
                    print('Password updated');
                  }, onError: (e) {
                    print(e);
                  });

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
      ),
    );
  }
}
