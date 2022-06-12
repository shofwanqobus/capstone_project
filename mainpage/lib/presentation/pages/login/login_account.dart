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

  late bool signInLoading = false;

  TextEditingController emailController = TextEditingController();
  late bool emailError = false;
  late String emailErrorMessage = "";

  TextEditingController passwordController = TextEditingController();
  late bool passwordError = false;
  late String passwordErrorMessage = "";
  late bool showPassword = false;

  late bool authError = false;
  late String authErrorMessage = "";

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
            const SizedBox(height: 30),
            if (authError)
              Text(
                authErrorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                  if (emailError) {
                    setState(() {
                      emailError = false;
                      emailErrorMessage = "";
                    });
                  }
                },
                controller: emailController,
                key: const Key('email'),
                decoration: InputDecoration(
                  errorText: emailErrorMessage != "" ? emailErrorMessage : null,
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
                  if (passwordError) {
                    setState(() {
                      passwordError = false;
                      passwordErrorMessage = "";
                    });
                  }
                },
                controller: passwordController,
                key: const Key('password'),
                obscureText: !showPassword,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  errorText:
                      passwordErrorMessage != "" ? passwordErrorMessage : null,
                  hintText: 'Password...',
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                try {
                  setState(() => signInLoading = true);

                  final email = emailController.text;
                  final password = passwordController.text;

                  if (!email.contains("@") || email.isEmpty) {
                    setState(() {
                      emailError = true;
                      emailErrorMessage = "Email is invalid";
                    });
                  }

                  if (password.length < 6) {
                    passwordError = true;
                    passwordErrorMessage =
                        "Password must contains at least 6 characters";
                  } else if (password.isEmpty) {
                    setState(() {
                      passwordError = true;
                      passwordErrorMessage = "Password is invalid";
                    });
                  }

                  if (emailError || passwordError) {
                    setState(() => signInLoading = false);
                    return;
                  }

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

                  setState(() => signInLoading = false);

                  emailController.clear();
                  passwordController.clear();

                  if (authError) {
                    setState(() {
                      authError = false;
                      authErrorMessage = "";
                    });
                  }

                  Navigator.pushNamed(context, homePage);
                } on FirebaseAuthException catch (e) {
                  // TODO: Error message, example: invalid email, invalid password, user not registered, ...
                  print("login error: $e");
                  print("error code: ${e.code}");

                  if (e.code == "user-not-found") {
                    setState(() {
                      authError = true;
                      authErrorMessage = "User not found";
                      signInLoading = false;
                    });
                  }
                } catch (e) {
                  //
                }
              },
              child: signInLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text('Log In', style: button),
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
