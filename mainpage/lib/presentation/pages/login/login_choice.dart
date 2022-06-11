import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: backgroundPrimary1,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 16, left: 28, right: 28),
                  child: Text(
                    'Welcome',
                    style: kHeading4,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  child: Text(
                    'Spend your holiday only with one click, and enjoy your trip',
                    style: textButton2,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 4,
                    ),
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      return loginBuildCard(index);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, logInAccount),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 245,
                    height: 55,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.supervisor_account,
                          color: Colors.black,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Text('Login with Account', style: kSubtitle),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, logInAccount),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 245,
                    height: 55,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.g_mobiledata,
                          color: Colors.black,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Text('Login with Google', style: kSubtitle),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, logInAccount),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 245,
                    height: 55,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.apple,
                          color: Colors.black,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Text('Login with iCloud', style: kSubtitle),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, logInAccount),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 245,
                    height: 55,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.facebook,
                          color: Colors.black,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Text('Login with Facebook', style: kSubtitle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, signUpAccount),
                  child: Text(
                    "Doesn't have an account? Sign Up Now.",
                    style: kBodyText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget loginBuildCard(int index) => Container(
      width: 150,
      decoration: BoxDecoration(
        color: backgroundPrimary2,
        borderRadius: BorderRadius.circular(15),
      ),
    );
