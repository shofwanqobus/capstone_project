import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAccountChangePassword extends StatefulWidget {
  const SettingsAccountChangePassword({Key? key}) : super(key: key);

  @override
  State<SettingsAccountChangePassword> createState() =>
      _SettingsAccountChangePasswordState();
}

class _SettingsAccountChangePasswordState
    extends State<SettingsAccountChangePassword> {
  late bool inputError = false;
  late bool confirmError = false;
  late bool showPassword = false;
  late String inputErrorMessage = "";
  late String confirmErrorMessage = "";
  late bool showConfirmPassword = false;

  TextEditingController controller = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;

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
                onChanged: (value) {
                  if (inputError) {
                    setState(() {
                      inputError = false;
                    });
                  }
                },
                key: const Key('Password'),
                controller: controller,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  errorText: inputError ? inputErrorMessage : null,
                  hintText: 'password...',
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
                onChanged: (value) {
                  if (confirmError) {
                    setState(() {
                      confirmError = false;
                    });
                  }
                },
                key: const Key('New Password'),
                controller: confirmController,
                obscureText: !showConfirmPassword,
                decoration: InputDecoration(
                  errorText: confirmError ? confirmErrorMessage : null,
                  hintText: 'password...',
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
                    value: showConfirmPassword,
                    onChanged: (value) {
                      setState(() {
                        showConfirmPassword = value!;
                      });
                    },
                  ),
                  const Text("Show Confirm Password")
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final newValue = controller.text;
                  final confirmValue = confirmController.text;

                  if (newValue.length < 6) {
                    inputErrorMessage =
                        "Password must at least contains 6 characters";

                    setState(() {
                      inputError = true;
                    });
                  } else if (newValue.isEmpty) {
                    inputErrorMessage = "Password is invalid";

                    setState(() {
                      inputError = true;
                    });
                  }

                  if (confirmValue.isEmpty) {
                    confirmErrorMessage = "Confirm password is invalid";

                    setState(() {
                      confirmError = true;
                    });
                  }

                  if (inputError || confirmError) {
                    return;
                  }

                  if (newValue != confirmValue) {
                    setState(() {
                      inputError = true;
                      inputErrorMessage = "Password does not match";
                      confirmError = true;
                      confirmErrorMessage = "Password does not match";
                    });
                    return;
                  }

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

                  const snackBar = SnackBar(
                    content: Text("Password updated"),
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
      ),
    );
  }
}
