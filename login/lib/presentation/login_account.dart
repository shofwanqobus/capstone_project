import 'package:flutter/material.dart';
import 'package:core/core.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({Key? key}) : super(key: key);

  @override
  _LoginAccount createState() => _LoginAccount();
}

class _LoginAccount extends State<LoginAccount> {
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
      body: Column(
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
              'Username',
              style: kSubtitle,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (query) {},
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
              'Password',
              style: kSubtitle,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (query) {},
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
            onPressed: () => Navigator.pushNamed(context, homePage),
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
            child: Text(
              "Doesn't have an account? Sign Up Now.",
              style: textButton,
            ),
          ),
        ],
      ),
    );
  }
}
