import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/mainpage.dart';

import 'utils/components.dart';

class UserFavorite extends StatelessWidget {
  const UserFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12.0),
            Center(
              child: Text("Favorites", style: kHeading6),
            ),
            Text(
              "Place/Trip (3)",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  HotelPlaceCard(),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
            Text(
              "Tickets (0)",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
