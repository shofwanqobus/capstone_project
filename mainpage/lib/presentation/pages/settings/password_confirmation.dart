import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

class SettingsPasswordConfirmation extends StatelessWidget {
  const SettingsPasswordConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Username',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (value) {},
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
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, settingsAccount);
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
