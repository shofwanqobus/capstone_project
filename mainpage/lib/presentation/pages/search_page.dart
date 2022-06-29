import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/data/models/trip_model.dart';
import 'package:mainpage/mainpage.dart';
import 'package:mainpage/presentation/pages/details/trip_detail_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  var textInput = "";
  var state = "empty";

  HotelModel? hotels;
  TripModel? trips;

  void loadData() async {
    String hotelJsonStr =
        await rootBundle.loadString('assets/local_hotel.json');
    String tripJsonStr = await rootBundle.loadString('assets/local_trip.json');

    Map<String, dynamic> hotelMap = jsonDecode(hotelJsonStr);
    Map<String, dynamic> tripMap = jsonDecode(tripJsonStr);

    hotels = HotelModel.fromJson(hotelMap);
    trips = TripModel.fromJson(tripMap);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  AppBar searchAppBar() {
    return AppBar(
      backgroundColor: backgroundPrimary1,
      toolbarHeight: 75,
      automaticallyImplyLeading: false,
      leading: const Icon(Icons.search, size: 36.0),
      title: const Text("Search", style: TextStyle(fontSize: 24.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(),
      backgroundColor: backgroundPrimary2,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                onChanged: (value) async {
                  if (value == "") {
                    state = "empty";
                  } else {
                    state = "hasData";
                  }

                  String hotelJsonStr =
                      await rootBundle.loadString('assets/local_hotel.json');
                  String tripJsonStr =
                      await rootBundle.loadString('assets/local_trip.json');

                  Map<String, dynamic> hotelMap = jsonDecode(hotelJsonStr);
                  Map<String, dynamic> tripMap = jsonDecode(tripJsonStr);

                  final closureTrips = TripModel.fromJson(tripMap);
                  final closureHotels = HotelModel.fromJson(hotelMap);

                  final tripFiltered = closureTrips.trip.where(
                    (val) => val.name.toLowerCase().contains(value),
                  );

                  final hotelFiltered = closureHotels.hotelItemsModel.where(
                    (val) => val.name.toLowerCase().contains(value),
                  );

                  setState(() {
                    trips!.trip = tripFiltered.toList();
                    hotels!.hotelItemsModel = hotelFiltered.toList();
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search",
                ),
              ),
              const SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    SearchTag(text: "Hotel"),
                    SearchTag(text: "Staycation"),
                    SearchTag(text: "Airplane"),
                    SearchTag(text: "Train"),
                    SearchTag(text: "Bus"),
                    SearchTag(text: "Trip"),
                  ],
                ),
              ),
              state == "empty"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(textInput),
                        Text(
                          "Last Search",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const LastSearchText(text: "Farmhouse Susu Lembang"),
                        const LastSearchText(text: "The Trans Luxury Hotel"),
                        const LastSearchText(text: "Floating Market"),
                      ],
                    )
                  : state == "hasData"
                      ? Column(
                          children: [
                            hotels != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: hotels!.hotelItemsModel.map((e) {
                                      return _hotelCard(context, e);
                                    }).toList(),
                                  )
                                : Container(),
                            trips != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: trips!.trip.map((e) {
                                      return _tripCard(context, e);
                                    }).toList(),
                                  )
                                : Container(),
                          ],
                        )
                      : const Text("no data"),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTag extends StatelessWidget {
  const SearchTag({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class LastSearchText extends StatelessWidget {
  const LastSearchText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 10.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

Widget _hotelCard(BuildContext context, HotelItemsModel hotel) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
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
