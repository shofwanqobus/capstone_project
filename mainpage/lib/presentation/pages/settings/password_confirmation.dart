import 'dart:convert';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPasswordConfirmation extends StatelessWidget {
  const SettingsPasswordConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String confirmPassword = "";

    final _auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: homeAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              "Password Confirmation",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
            child: Text(
              'Password',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (value) => confirmPassword = value,
              key: const Key('Confirm Password'),
              decoration: InputDecoration(
                hintText: 'Confirm password...',
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
                final prefs = await SharedPreferences.getInstance();
                final data = json.decode(prefs.getString("data")!);
                final password = data["password"];

                if (password != confirmPassword) throw "Password incorrect!";

                Navigator.pop(context);
                Navigator.pushNamed(context, settingsAccount);
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
