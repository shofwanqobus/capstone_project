import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/data/models/trip_model.dart';
import 'package:mainpage/mainpage.dart';
import 'package:mainpage/presentation/pages/details/trip_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _auth = FirebaseAuth.instance;

  int _currentIndex = 0;

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  Future<void> _confirmSignOut() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Confirmation")),
          content: SingleChildScrollView(
            child: Column(
              children: const [
                Text("Sign out?"),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[400],
              ),
              child: const Text("Confirm"),
              onPressed: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove("data");

                  await _auth.signOut();

                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: backgroundPrimary1,
              ),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  final List<Widget> _listWidget = [
    const HomeScreen(),
    const BookedPage(),
    const SearchPage(),
    const UserPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      backgroundColor: backgroundPrimary2,
      icon: Icon(Icons.home, color: backgroundPrimary2, size: 50),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      backgroundColor: backgroundPrimary2,
      icon: Icon(Icons.bookmark_rounded, color: backgroundPrimary2, size: 50),
      label: 'Booked',
    ),
    const BottomNavigationBarItem(
      backgroundColor: backgroundPrimary2,
      icon: Icon(Icons.search, color: backgroundPrimary2, size: 50),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      backgroundColor: backgroundPrimary2,
      icon: Icon(Icons.supervisor_account_rounded,
          color: backgroundPrimary2, size: 50),
      label: 'User',
    ),
    const BottomNavigationBarItem(
      backgroundColor: backgroundPrimary2,
      icon: Icon(Icons.settings, color: backgroundPrimary2, size: 50),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _confirmSignOut();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundPrimary2,
          body: _listWidget[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundPrimary1,
            unselectedLabelStyle: textButton2,
            selectedLabelStyle: textButton2,
            currentIndex: _currentIndex,
            onTap: _updateIndex,
            items: _bottomNavBarItems,
          ),
        ),
      ),
    );
  }
}

AppBar homeAppBar() {
  return AppBar(
    backgroundColor: backgroundPrimary1,
    toolbarHeight: 75,
    leading: const Icon(
      Icons.home,
      size: 36,
      color: backgroundPrimary2,
    ),
    title: Text('Home Page', style: button),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.mark_email_unread,
            size: 36, color: backgroundPrimary2),
      ),
      Container(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications,
              size: 36, color: backgroundPrimary2),
        ),
      ),
    ],
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      backgroundColor: backgroundPrimary2,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: backgroundPrimary1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.hotel_rounded,
                        size: 50, color: backgroundPrimary2),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: backgroundPrimary1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.airplane_ticket_sharp,
                        size: 50, color: backgroundPrimary2),
                    onPressed: () => Navigator.pushNamed(context, planeTicket),
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: backgroundPrimary1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.location_city_rounded,
                        size: 50, color: backgroundPrimary2),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: backgroundPrimary1,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.menu,
                        size: 50, color: backgroundPrimary2),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Hotel',
                style: kHeading6,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              height: 250,
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_hotel.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> jsonMap = jsonDecode(snapshot.data!);
                    final hotels = HotelModel.fromJson(jsonMap);

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: hotels.hotelItemsModel.length,
                      itemBuilder: (context, index) {
                        return _hotelCard(
                            context, hotels.hotelItemsModel[index]);
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Trip',
                style: kHeading6,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              height: 250,
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_trip.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> jsonMap = jsonDecode(snapshot.data!);
                    final trips = TripModel.fromJson(jsonMap);

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: trips.trip.length,
                      itemBuilder: (context, index) {
                        return _tripCard(context, trips.trip[index]);
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hotelCard(BuildContext context, HotelItemsModel hotel) {
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'IDR', symbol: "Rp. ");

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
                              Text(currencyFormatter.format(hotel.price),
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
  }

  Widget _tripCard(BuildContext context, TripItemsModel trip) {
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'IDR', symbol: "Rp. ");

    return Align(
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
                              Text(currencyFormatter.format(trip.price),
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
  }
}
