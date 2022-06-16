import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/presentation/provider/database_provider.dart';
import 'package:mainpage/presentation/provider/favorited_database_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.hotel}) : super(key: key);

  final HotelItemsModel hotel;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<FavDatabaseProvider>(
          create: (_) => FavDatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: Scaffold(body: _details(context)),
    );
  }

  Widget _details(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: hotel.photoUrl!,
            width: screenWidth,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Consumer<FavDatabaseProvider>(
                    builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                        future: provider.isFavorited(hotel.id),
                        builder: ((context, snapshot) {
                          var isFavorited = snapshot.data ?? false;
                          return CircleAvatar(
                            backgroundColor: Colors.white54,
                            child: isFavorited
                                ? IconButton(
                                    icon: const Icon(Icons.favorite),
                                    color: Colors.red,
                                    onPressed: () =>
                                        provider.removeFavoriteHotel(hotel.id),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    color: Colors.red,
                                    onPressed: () =>
                                        provider.addFavoritedHotel(hotel),
                                  ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 225),
            height: screenHeight,
            decoration: const BoxDecoration(
              color: backgroundPrimary2,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            hotel.name,
                            style: headingDetail,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Row(
                          children: [
                            Icon(Icons.location_pin, color: Colors.amber[400]),
                            Text(hotel.address, style: kBodyText),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Description',
                          style: kHeading6,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          hotel.description,
                          style: kBodyText,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Accommodations',
                          style: kHeading6,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 10),
                        // ListView(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, homePage),
                              child: Text('Review', style: textButton2),
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                shadowColor: Colors.black,
                                primary: backgroundPrimary1,
                                minimumSize: const Size(60, 60),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Consumer<DatabaseProvider>(
                              builder: (context, provider, child) {
                                return FutureBuilder<bool>(
                                    future: provider.isBooked(hotel.id),
                                    builder: (context, snapshot) {
                                      return ElevatedButton(
                                        onPressed: () =>
                                            provider.bookedHotel(hotel),
                                        child: Text('Book Now',
                                            style: textButton2),
                                        style: ElevatedButton.styleFrom(
                                          elevation: 2,
                                          shadowColor: Colors.black,
                                          primary: backgroundPrimary1,
                                          minimumSize: const Size(60, 60),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
