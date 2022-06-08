import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/presentation/pages/home_page.dart';

import 'utils/components.dart';

class UserRecentPlaces extends StatelessWidget {
  const UserRecentPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
              Center(
                child: Text(
                  "Recent Places",
                  style: kHeading6,
                ),
              ),
              Text(
                "Place/Trip (4)",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    PlaceCard(),
                    PlaceCard(),
                    PlaceCard(),
                    PlaceCard(),
                  ],
                ),
              ),
              const SizedBox(height: 14.0),
              Text(
                "Tickets (1)",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Column(
                children: const [
                  TicketCard(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
