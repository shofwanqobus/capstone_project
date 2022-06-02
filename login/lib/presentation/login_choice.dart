import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({Key? key}) : super(key: key);

  @override
  _LoginChoice createState() => _LoginChoice();
}

class _LoginChoice extends State<LoginChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: AppBar(
        backgroundColor: backgroundPrimary1,
        title: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Welcome',
                style: kHeading4,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Spend your holiday only with one click, and enjoy your trip',
                style: kSubtitle,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        toolbarHeight: 280,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, logInAccount),
              icon: const Icon(
                Icons.supervisor_account,
                size: 40,
                color: Colors.black,
              ),
              label: Text('Login with Account', style: kSubtitle),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(250, 55),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.g_mobiledata_rounded,
                size: 40,
                color: Colors.black,
              ),
              label: Text('Login with Google', style: kSubtitle),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(250, 55),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.apple,
                size: 40,
                color: Colors.black,
              ),
              label: Text('Login with iCloud', style: kSubtitle),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(250, 55),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.facebook,
                size: 40,
                color: Colors.black,
              ),
              label: Text('Login with Facebook', style: kSubtitle),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(250, 55),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, signUpAccount),
              child: Text(
                "Doesn't have an account? Sign Up Now.",
                style: kBodyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
