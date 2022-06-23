import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

class SettingsSchedule extends StatefulWidget {
  const SettingsSchedule({Key? key}) : super(key: key);

  @override
  State<SettingsSchedule> createState() => _LanguageState();
}

class _LanguageState extends State<SettingsSchedule> {
  late bool _notification;

  @override
  void initState() {
    super.initState();
    _notification = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              "Schedule",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Notification',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch.adaptive(
                value: _notification,
                onChanged: (value) {
                  setState(() {
                    _notification = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
      backgroundColor: backgroundPrimary2,
    );
  }
}
