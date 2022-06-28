import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar userAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    toolbarHeight: 0,
    elevation: 0,
    automaticallyImplyLeading: false,
  );
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final isGoogleSignedIn =
        _auth.currentUser!.providerData[0].providerId == "google.com";

    final googleUser = _auth.currentUser!.providerData[0];

    Future<String> getData() async {
      final prefs = await SharedPreferences.getInstance();
      var data = prefs.getString("data");

      if (data != null) {
        return data;
      } else {
        return "";
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: backgroundPrimary1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final data = json.decode(snapshot.data);

                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: isGoogleSignedIn
                                ? NetworkImage(
                                    googleUser.photoURL!,
                                  )
                                : const NetworkImage(
                                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.NYngvQQW1fRwQkUE080elAHaHa%26pid%3DApi&f=1",
                                  ),
                            radius: 40,
                          ),
                          const SizedBox(width: 60.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome, " + data["username"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .fontSize,
                                  color: Colors.white,
                                ),
                              ),
                              const MediumText(text: "How's your day?"),
                              const MediumText(
                                text: "We hope that you're fine",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const MediumText(text: "Total Trip"),
                            MediumText(text: data["totalTrip"].toString()),
                          ],
                        ),
                        Column(
                          children: [
                            const MediumText(text: "Points"),
                            MediumText(text: data["points"].toString()),
                          ],
                        ),
                        Column(
                          children: [
                            const MediumText(text: "Member"),
                            MediumText(text: data["member"]),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                print("get data error: ${snapshot.error}");
                return const Center(child: Text("Error"));
              } else {
                return Column(
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: const [
                            MediumText(text: "Total Trip"),
                            MediumText(text: "0"),
                          ],
                        ),
                        Column(
                          children: const [
                            MediumText(text: "Points"),
                            MediumText(text: "0"),
                          ],
                        ),
                        Column(
                          children: const [
                            MediumText(text: "Member"),
                            MediumText(text: ""),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              }
            },
          ),
        ),
        const SizedBox(height: 125.0),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UserButton(
                  icon: Icons.favorite,
                  text: "Favorite",
                  onTap: () {
                    Navigator.pushNamed(context, userFavorite);
                  }),
              UserButton(
                  icon: Icons.location_on,
                  text: "Recent Place",
                  onTap: () {
                    Navigator.pushNamed(context, userRecentPlaces);
                  }),
              UserButton(
                  icon: Icons.location_history_sharp,
                  text: "Change Points",
                  onTap: () {
                    Navigator.pushNamed(context, userChangePoints);
                  }),
              UserButton(
                  icon: Icons.rate_review,
                  text: "Reviews",
                  onTap: () {
                    Navigator.pushNamed(context, userReviews);
                  }),
            ],
          ),
        )
      ],
    );
  }
}

class UserButton extends StatelessWidget {
  const UserButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: backgroundPrimary1,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 12.0),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class MediumText extends StatelessWidget {
  const MediumText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
        color: Colors.white,
      ),
    );
  }
}
