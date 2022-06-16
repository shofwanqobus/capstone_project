import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/mainpage.dart';
import 'package:mainpage/presentation/provider/favorited_database_provider.dart';
import 'package:provider/provider.dart';

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

class HotelPlaceCard extends StatelessWidget {
  const HotelPlaceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavDatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorited.length,
            itemBuilder: (context, index) {
              return _favHotel(
                provider.favorited[index],
              );
            },
          );
        } else if (provider.state == ResultState.noData) {
          return Center(child: Text(provider.message));
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Icon(Icons.wifi_off, size: 50),
                ),
                Text(
                  provider.message,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

  Widget _favHotel(HotelItemsModel hotel) {
    return Consumer<FavDatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorited(hotel.id),
        builder: (context, state) {
          return Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DetailPage(hotel: hotel);
                  }),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: hotel.photoUrl!,
                        height: 125,
                        width: 125,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hotel.name, style: kBodyText),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber[400],
                                    ),
                                    Text('${hotel.rating}', style: kBodyText),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.price_change,
                                      color: Colors.amber[400],
                                    ),
                                    Text('Rp. ${hotel.price}',
                                        style: kBodyText),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
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
