import 'package:core/core.dart';
import 'package:flutter/material.dart';

class UserReviews extends StatelessWidget {
  const UserReviews({Key? key}) : super(key: key);

  AppBar reviews() {
    return AppBar(
      backgroundColor: backgroundPrimary1,
      toolbarHeight: 75,
      title: Text('Reviews', style: button),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reviews(),
      backgroundColor: backgroundPrimary2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.speaker, size: 75, color: black),
            const SizedBox(height: 5),
            Text('Coming Soon!', style: kHeading6),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;
  final String img = "";
  final String title = "Floating Market Lembang";
  final double rating = 5.0;
  final String review =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                SizedBox(
                  width: 150.0,
                  child: RichText(
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: review,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 80.0,
              height: 80.0,
              child: Placeholder(),
            )
          ],
        ),
      ),
    );
  }
}
