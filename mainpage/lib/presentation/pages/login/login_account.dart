import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({Key? key}) : super(key: key);

  @override
  _LoginAccount createState() => _LoginAccount();
}

class _LoginAccount extends State<LoginAccount> {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: AppBar(
        backgroundColor: backgroundPrimary2,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Go Back',
          style: kHeading6,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 125,
                  width: 350,
                  decoration: const BoxDecoration(
                    color: backgroundPrimary1,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Text(
                    'Sign In',
                    style: kHeading4,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
              child: Text(
                'Email',
                style: kSubtitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (query) {
                  email = query;
                },
                key: const Key('email'),
                decoration: InputDecoration(
                  hintText: 'Email...',
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
                'Password',
                style: kSubtitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (query) {
                  password = query;
                },
                key: const Key('password'),
                decoration: InputDecoration(
                  hintText: 'Password...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                textInputAction: TextInputAction.send,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();

                  // used when removing the account from the plaform
                  // in lib/presentation/pages/settings/account_settings...
                  // ... > Delete Account
                  // resetted when logout

                  final user = await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  final docRef = db.collection("users").doc(user.user!.email);

                  docRef.get().then(
                    (DocumentSnapshot doc) async {
                      final data = doc.data() as Map<String, dynamic>;
                      await prefs.setString("data", json.encode(data));
                    },
                    // onError: (e) => print("Error getting document: $e"),
                  );

                  Navigator.pushNamed(context, homePage);
                } catch (e) {
                  // TODO: Error message, example: invalid email, invalid password, user not registered, ...
                  // print(e);
                }
              },
              child: Text('Log In', style: button),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                shadowColor: Colors.black,
                primary: backgroundPrimary1,
                minimumSize: const Size(175, 60),
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, signUpAccount),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Doesn't have an account? ",
                    style: textButton,
                  ),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: textButton.fontSize! + 2,
                      color: backgroundPrimary1,
                      fontWeight: textButton.fontWeight,
                    ),
                  ),
                  Text(
                    " now.",
                    style: textButton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
