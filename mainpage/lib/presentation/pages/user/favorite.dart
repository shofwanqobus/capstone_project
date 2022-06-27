import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/data/models/trip_model.dart';
import 'package:mainpage/mainpage.dart';
import 'package:mainpage/presentation/pages/details/trip_detail_screen.dart';
import 'package:mainpage/presentation/provider/favorited_database_provider.dart';
import 'package:provider/provider.dart';

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
      body: userFavoriteBody(context),
    );
  }
}

Widget userFavoriteBody(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Hotel",
            style: textButton,
          ),
        ),
        Consumer<FavoriteDatabaseProvider>(
          builder: (context, value, child) {
            value.getFavoriteHotels();

            if (value.hotelState == ResultState.hasData) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                height: 200,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  scrollDirection: Axis.vertical,
                  itemCount: value.favoriteHotels.length,
                  itemBuilder: (context, index) {
                    return _hotelCard(context, value.favoriteHotels[index]);
                  },
                ),
              );
            } else if (value.hotelState == ResultState.noData) {
              return Center(
                child: Column(
                  children: const [
                    Icon(Icons.info),
                    Text("No Favorite yet"),
                  ],
                ),
              );
            } else {
              return const Center(child: Icon(Icons.hourglass_empty));
            }
          },
        ),
        const SizedBox(height: 14.0),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Trip",
            style: textButton,
          ),
        ),
        Consumer<FavoriteDatabaseProvider>(
          builder: (context, value, child) {
            value.getFavoriteTrips();

            if (value.tripState == ResultState.hasData) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                height: 200,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  scrollDirection: Axis.vertical,
                  itemCount: value.favoriteTrips.length,
                  itemBuilder: (context, index) {
                    return _tripCard(context, value.favoriteTrips[index]);
                  },
                ),
              );
            } else if (value.tripState == ResultState.noData) {
              return Center(
                child: Column(
                  children: const [
                    Icon(Icons.info),
                    Text("No Favorite yet"),
                  ],
                ),
              );
            } else {
              return const Center(child: Icon(Icons.hourglass_empty));
            }
          },
        ),
      ],
    ),
  );
}

Widget _hotelCard(BuildContext context, HotelItemsModel hotel) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Align(
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
                              Text('Rp. ${hotel.price}', style: kBodyText),
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
    ),
  );
}

Widget _tripCard(BuildContext context, TripItemsModel trip) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TripDetailPage(trip: trip);
            }),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: trip.photoUrl!,
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
                    Text(trip.name, style: kBodyText),
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
                              Text('${trip.rating}', style: kBodyText),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.price_change,
                                color: Colors.amber[400],
                              ),
                              Text('Rp. ${trip.price}', style: kBodyText),
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
    ),
  );
}
