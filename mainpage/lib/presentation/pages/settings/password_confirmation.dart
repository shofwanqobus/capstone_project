import 'dart:convert';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPasswordConfirmation extends StatefulWidget {
  const SettingsPasswordConfirmation({Key? key}) : super(key: key);

  @override
  State<SettingsPasswordConfirmation> createState() =>
      _SettingsPasswordConfirmationState();
}

class _SettingsPasswordConfirmationState
    extends State<SettingsPasswordConfirmation> {
  late bool loading = false;
  late String confirmPassword = "";
  late bool confimPasswordError = false;
  late String confimPasswordErrorMessage = "";
  late bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: settingsAppBar(),
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
              onChanged: (value) {
                confirmPassword = value;

                if (confimPasswordError) {
                  setState(() {
                    confimPasswordError = false;
                    confimPasswordErrorMessage = "";
                  });
                }
              },
              key: const Key('Confirm Password'),
              obscureText: !showPassword,
              decoration: InputDecoration(
                errorText: confimPasswordErrorMessage != ""
                    ? confimPasswordErrorMessage
                    : null,
                hintText: 'Confirm password...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              textInputAction: TextInputAction.send,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Checkbox(
                  value: showPassword,
                  onChanged: (value) {
                    setState(() {
                      showPassword = value!;
                    });
                  },
                ),
                const Text("Show Password")
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                setState(() => loading = true);

                if (confirmPassword.length < 6) {
                  confimPasswordError = true;
                  confimPasswordErrorMessage =
                      "Password must contains at least 6 characters";
                } else if (confirmPassword == "") {
                  setState(() {
                    confimPasswordError = true;
                    confimPasswordErrorMessage = "Password is invalid";
                  });
                }

                if (confimPasswordError) {
                  setState(() => loading = false);
                  return;
                }

                final prefs = await SharedPreferences.getInstance();
                final data = json.decode(prefs.getString("data")!);
                final password = data["password"];

                if (password != confirmPassword) throw "Password incorrect!";

                setState(() => loading = false);

                Navigator.pop(context);
                Navigator.pushNamed(context, settingsAccount);
              } catch (e) {
                print(e);
              }
            },
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text('Submit', style: button),
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
