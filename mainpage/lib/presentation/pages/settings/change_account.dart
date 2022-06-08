import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

class SettingsChangeAccount extends StatelessWidget {
  const SettingsChangeAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: homeAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Center(
              child: Text(
                "Change Account",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Column(
              children: [
                const AccountTile(),
                const AccountTile(),
                const SizedBox(height: 12.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    primary: backgroundPrimary1,
                  ),
                  label: const Text("Add Another account"),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[400],
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout From All Accounts"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile({Key? key}) : super(key: key);

  final String name = "Andre";
  final String email = "andre@be-traveled.com";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 12.0),
          const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.NYngvQQW1fRwQkUE080elAHaHa%26pid%3DApi&f=1",
            ),
            radius: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          ElevatedButton(
            child: const Text("Logout"),
            style: ElevatedButton.styleFrom(primary: Colors.red[300]),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
