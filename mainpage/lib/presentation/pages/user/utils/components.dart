import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({Key? key}) : super(key: key);

  final String img = "";
  final String title = "Floating Market Lembang";
  final double rating = 4.8;
  final String price = "Rp 3.000.000,00";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120.0,
            height: 120.0,
            child: Placeholder(),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
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
          Row(
            children: [
              Icon(
                Icons.price_change,
                color: Colors.amber[400],
              ),
              Text(price),
            ],
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({Key? key}) : super(key: key);

  final String title = "Garuda Airlines";
  final String time = "10:42 a.m.";
  final String travel = "Bandara Soekarno-Hatta";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: 60.0,
              height: 40.0,
              child: Placeholder(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                Text(time),
                Text(travel),
              ],
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text("detail"),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
