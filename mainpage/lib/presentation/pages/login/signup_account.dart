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

  late bool signUpLoading = false;

  late String username = "";
  late bool usernameError = false;

  late String email = "";
  late bool emailError = false;

  late String password = "";
  late bool passwordError = false;
  late String passwordErrorMessage = "";
  late bool showPassword = false;

  late String phoneNumber = "";
  late bool phoneNumberError = false;

  late String dateOfBirth = "";
  late bool dateOfBirthError = false;

  late bool checkbox = false;
  late bool checkboxError = false;

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
                onChanged: (query) {
                  username = query;
                  if (usernameError) {
                    setState(() => usernameError = false);
                  }
                },
                key: const Key('username'),
                decoration: InputDecoration(
                  errorText: usernameError ? "Username is invalid" : null,
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
                onChanged: (query) {
                  email = query;
                  if (emailError) {
                    setState(() => emailError = false);
                  }
                },
                key: const Key('email'),
                decoration: InputDecoration(
                  errorText: emailError ? "Email is invalid" : null,
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
                onChanged: (query) {
                  password = query;
                  if (passwordError) {
                    setState(() {
                      passwordErrorMessage = "";
                      passwordError = false;
                    });
                  }
                },
                key: const Key('password'),
                obscureText: !showPassword,
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
                onChanged: (query) {
                  phoneNumber = query;
                  if (phoneNumberError) {
                    setState(() => phoneNumberError = false);
                  }
                },
                key: const Key('phone-number'),
                decoration: InputDecoration(
                  errorText:
                      phoneNumberError ? "Phone Number is invalid" : null,
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
                onChanged: (query) {
                  dateOfBirth = query;
                  if (dateOfBirthError) {
                    setState(() => dateOfBirthError = false);
                  }
                },
                key: const Key('date-of-birth'),
                decoration: InputDecoration(
                  errorText:
                      dateOfBirthError ? "Date of Birth is invalid" : null,
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
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          checkboxError ? Colors.red : Colors.black54,
                    ),
                    child: Checkbox(
                      value: checkbox,
                      onChanged: (value) {
                        setState(() => checkbox = value!);

                        if (checkboxError) {
                          setState(() => checkboxError = false);
                        }
                      },
                    ),
                  ),
                ),
                Text(
                  'I have agreed with terms & conditions',
                  style: kBodyText,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  setState(() => signUpLoading = true);

                  if (username == "") {
                    setState(() => usernameError = true);
                  }
                  if (email == "") {
                    setState(() => emailError = true);
                  }
                  if (password.length < 6) {
                    setState(() {
                      passwordErrorMessage =
                          "Password must contains at least 6 character";
                      passwordError = true;
                    });
                  } else if (password == "") {
                    setState(() {
                      passwordErrorMessage = "Password is invalid";
                      passwordError = true;
                    });
                  }
                  if (phoneNumber == "") {
                    setState(() => phoneNumberError = true);
                  }
                  if (dateOfBirth == "") {
                    setState(() => dateOfBirthError = true);
                  }
                  if (!checkbox) {
                    setState(() => checkboxError = true);
                  }

                  if (usernameError ||
                      emailError ||
                      passwordError ||
                      phoneNumberError ||
                      dateOfBirthError ||
                      checkboxError) {
                    setState(() => signUpLoading = false);
                    return;
                  }

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

                  const snackBar = SnackBar(
                    content: Text("Account successfully created"),
                  );

                  setState(() => signUpLoading = false);

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.pushNamed(context, logInAccount);
                } catch (e) {
                  // TODO: Error message, example: email poorly written, ...
                  print("signup error: $e");
                }
              },
              child: signUpLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text('Create Account', style: button),
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
