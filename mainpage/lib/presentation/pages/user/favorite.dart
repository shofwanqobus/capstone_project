import 'package:core/core.dart';
import 'package:flutter/material.dart';
// import 'utils/components.dart';

class UserFavorite extends StatelessWidget {
  const UserFavorite({Key? key}) : super(key: key);

  AppBar favoriteAppBar() {
    return AppBar(
      backgroundColor: backgroundPrimary1,
      toolbarHeight: 75,
      title: Text('Favorite Place/Trip', style: button),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: favoriteAppBar(),
      backgroundColor: backgroundPrimary2,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Place",
                style: textButton,
              ),
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  // HotelPlaceCard(),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Trip",
                style: textButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
