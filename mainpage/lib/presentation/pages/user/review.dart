import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

class UserReview extends StatelessWidget {
  const UserReview({Key? key}) : super(key: key);

  final String title = "Floating Market Lembang";
  final double rating = 5.0;
  final String review =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                width: 140.0,
                height: 140.0,
                child: Placeholder(),
              ),
              const SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber[400],
                  ),
                  Text(rating.toString()),
                ],
              ),
              Text(
                review,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12.0),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: backgroundPrimary1,
                ),
                label: const Text("Edit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
