import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/data/models/plane_ticket_model.dart';
import 'package:mainpage/data/models/trip_model.dart';
import 'package:mainpage/presentation/provider/database_provider.dart';
import 'package:mainpage/presentation/provider/ticket_database_provider.dart';
import 'package:mainpage/presentation/provider/trip_database_provider.dart';
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
    const TripTab(),
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
                  text: 'Place',
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
                  text: 'Trip',
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

// class BookedButton extends StatelessWidget {
//   const BookedButton({Key? key, required this.status}) : super(key: key);

//   final bool status;

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: () {},
//       child: Text(status ? "Booked" : "Cancelled"),
//       style: OutlinedButton.styleFrom(
//         primary: status ? Colors.green : Colors.redAccent,
//         side: BorderSide(
//           width: 1.0,
//           color: status ? Colors.green : Colors.red,
//         ),
//       ),
//     );
//   }
// }

class PlaceTab extends StatelessWidget {
  const PlaceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
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
                  child: Icon(Icons.error, size: 50),
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
              leading: Hero(
                tag: hotel.photoUrl!,
                child: CachedNetworkImage(
                  imageUrl: hotel.photoUrl!,
                  width: 100,
                ),
              ),
              title: Container(
                padding: const EdgeInsets.only(),
                child: Text(hotel.name),
              ),
              subtitle: Container(
                child: Column(
                  children: [
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

  Widget _listTickets(BuildContext context) {
    return Consumer<TicketDatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.booked.length,
            itemBuilder: (context, index) {
              return _bookedTickets(
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

  Widget _bookedTickets(PlaneTicketItems tickets) {
    return Consumer<TicketDatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBooked(tickets.id),
          builder: (context, snapshot) {
            return Material(
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                title: Container(
                  child: Text(tickets.name),
                ),
                subtitle: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.price_change,
                              size: 15,
                            ),
                            Text('${tickets.price}'),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TicketDatabaseProvider>(
      create: (_) => TicketDatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: Scaffold(body: _listTickets(context)),
    );
  }
}

class TripTab extends StatelessWidget {
  const TripTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TripDatabaseProvider>(
      create: (_) => TripDatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: Scaffold(body: _listBooked(context)),
    );
  }

  Widget _listBooked(BuildContext context) {
    return Consumer<TripDatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.booked.length,
            itemBuilder: (context, index) {
              return _bookedTrip(
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
                  child: Icon(Icons.error, size: 50),
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

  Widget _bookedTrip(TripItemsModel trip) {
    return Consumer<TripDatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isBooked(trip.id),
        builder: (context, snapshot) {
          return Material(
            child: ListTile(
              leading: Hero(
                tag: trip.photoUrl!,
                child: CachedNetworkImage(
                  imageUrl: trip.photoUrl!,
                  width: 100,
                ),
              ),
              title: Container(
                padding: const EdgeInsets.only(),
                child: Text(trip.name),
              ),
              subtitle: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.price_change,
                            size: 15,
                          ),
                          Text('${trip.price}'),
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
