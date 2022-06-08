import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.NYngvQQW1fRwQkUE080elAHaHa%26pid%3DApi&f=1",
                    ),
                    radius: 40,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, Sarah",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                          color: Colors.white,
                        ),
                      ),
                      const MediumText(text: "How's your day?"),
                      const MediumText(text: "We hope that you're fine"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      MediumText(text: "Total Trip"),
                      MediumText(text: "40"),
                    ],
                  ),
                  Column(
                    children: const [
                      MediumText(text: "Points"),
                      MediumText(text: "245"),
                    ],
                  ),
                  Column(
                    children: const [
                      MediumText(text: "Member"),
                      MediumText(text: "Silver"),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 16.0),
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
