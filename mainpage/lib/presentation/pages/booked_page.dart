import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/presentation/pages/details/detail_screen.dart';
import 'package:mainpage/presentation/provider/database_provider.dart';
import 'package:provider/provider.dart';

class BookedPage extends StatefulWidget {
  const BookedPage({Key? key}) : super(key: key);

  @override
  State<BookedPage> createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {
  int _currentTabIndex = 0;

  final List _body = [
    const PlaceTab(),
    const TicketTab(),
    const Placeholder(),
  ];

  void _updateIndex(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => _updateIndex(0),
                child: TopText(
                  text: 'Place/Trip',
                  primary: _currentTabIndex == 0 ? true : false,
                ),
              ),
              InkWell(
                onTap: () => _updateIndex(1),
                child: TopText(
                  text: 'Tickets',
                  primary: _currentTabIndex == 1 ? true : false,
                ),
              ),
              InkWell(
                onTap: () => _updateIndex(2),
                child: TopText(
                  text: 'Others',
                  primary: _currentTabIndex == 2 ? true : false,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 5,
          thickness: 2,
        ),
        _body[_currentTabIndex],
      ],
    );
  }
}

class TopText extends StatelessWidget {
  const TopText({Key? key, required this.text, required this.primary})
      : super(key: key);

  final String text;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
          color: primary
              ? const Color.fromARGB(255, 84, 99, 85)
              : backgroundPrimary1,
          fontWeight: primary ? FontWeight.bold : FontWeight.w400,
        ),
      ),
    );
  }
}

class BookedButton extends StatelessWidget {
  const BookedButton({Key? key, required this.status}) : super(key: key);

  final bool status;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Text(status ? "Booked" : "Cancelled"),
      style: OutlinedButton.styleFrom(
        primary: status ? Colors.green : Colors.redAccent,
        side: BorderSide(
          width: 1.0,
          color: status ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}

class PlaceTab extends StatelessWidget {
  const PlaceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: Scaffold(body: _listBooked(context)),
    );
  }

  Widget _listBooked(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.booked.length,
            itemBuilder: (context, index) {
              return _bookedHotel(
                provider.booked[index],
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

  Widget _bookedHotel(HotelItemsModel hotel) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isBooked(hotel.id),
        builder: (context, snapshot) {
          return Material(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Hero(
                tag: hotel.photoUrl!,
                child: CachedNetworkImage(
                  imageUrl: hotel.photoUrl!,
                  width: 100,
                ),
              ),
              title: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 2,
                  bottom: 4,
                ),
                child: Text(hotel.name),
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.price_change,
                            size: 15,
                          ),
                          Text('${hotel.price}'),
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

class TicketTab extends StatelessWidget {
  const TicketTab({Key? key}) : super(key: key);

  final String date = "Kamis, 19 Agustus 2022";
  final String time = "14:12";
  final String title = "Garuda Airlines (IDN > LA)";
  final int price = 16020228;
  final String location = "Bandara Soekarno - Hatta";
  final bool booked = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date + " " + time,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: Colors.yellow[700],
                              ),
                              Text(price.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.yellow[700],
                              ),
                              Text(location.toString()),
                            ],
                          ),
                        ],
                      ),
                      BookedButton(status: booked),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
