import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpAccount extends StatefulWidget {
  const SignUpAccount({Key? key}) : super(key: key);

  @override
  _SignUpAccount createState() => _SignUpAccount();
}

class _SignUpAccount extends State<SignUpAccount> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  late String username;
  late String email;
  late String password;
  late String phoneNumber;
  late String dateOfBirth;
  late bool checkbox = false;

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
                    'Create Account',
                    style: kHeading5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
              child: Text(
                'Username',
                style: kSubtitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (query) => username = query,
                key: const Key('username'),
                decoration: InputDecoration(
                  hintText: 'Username...',
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
                'Email',
                style: kSubtitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                key: const Key('email'),
                decoration: InputDecoration(
                  hintText: 'E-mail...',
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
                onChanged: (value) {
                  password = value;
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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, left: 52, bottom: 4),
              child: Text(
                'Phone Number',
                style: kSubtitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (query) => phoneNumber = query,
                key: const Key('phone-number'),
                decoration: InputDecoration(
                  hintText: 'Phone Number...',
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
                'Date of Birth',
                style: kSubtitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (query) => dateOfBirth = query,
                key: const Key('date-of-birth'),
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                textInputAction: TextInputAction.send,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, left: 40),
              child: Text(
                'Terms & Conditions',
                style: kHeading6,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 36),
                  child: Checkbox(
                    value: checkbox,
                    onChanged: (value) {
                      setState(
                        () {
                          checkbox = value!;
                        },
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text('I have agreed with terms & conditions',
                      style: kBodyText),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (!checkbox) throw "terms and conditions is a requirement";

                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  final insertUser = <String, dynamic>{
                    "id": newUser.user!.uid,
                    "username": username,
                    "email": email,
                    "password": password,
                    "phone_number": phoneNumber,
                    "date_of_birth": dateOfBirth,
                  };

                  _db.collection("users").doc(email).set(insertUser);

                  Navigator.pushNamed(context, logInAccount);
                } catch (e) {
                  // TODO: Error message, example: checkbox not checked, email poorly written, password lesser than 6, ...
                  // print(e);
                }
              },
              child: Text('Create Account', style: button),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                shadowColor: Colors.black,
                primary: backgroundPrimary1,
                minimumSize: const Size(200, 55),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
