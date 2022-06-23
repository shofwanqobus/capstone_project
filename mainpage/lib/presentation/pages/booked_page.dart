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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundPrimary1,
          leading: const Icon(
            Icons.bookmark_rounded,
            size: 36,
            color: backgroundPrimary2,
          ),
          title: Text('Booked', style: button),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Place'),
              Tab(text: 'Tickets'),
              Tab(text: 'Trip'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PlaceTab(),
            TicketTab(),
            TripTab(),
          ],
        ),
      ),
    );
  }
}

class PlaceTab extends StatelessWidget {
  const PlaceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: Scaffold(
        backgroundColor: backgroundPrimary2,
        body: _listBooked(context),
      ),
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
            color: backgroundPrimary2,
            child: ListTile(
              leading: Hero(
                tag: hotel.photoUrl!,
                child: CachedNetworkImage(
                  imageUrl: hotel.photoUrl!,
                  alignment: Alignment.center,
                  height: 60,
                  width: 100,
                ),
              ),
              title: Container(
                padding: const EdgeInsets.only(top: 12),
                child: Text(hotel.name),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.address),
                  Text('Rp. ${hotel.price}'),
                ],
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

  Widget _bookedTickets(PlaneTicketItems tickets) {
    return Consumer<TicketDatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBooked(tickets.id),
          builder: (context, snapshot) {
            return Material(
              color: backgroundPrimary2,
              child: ListTile(
                leading: const Icon(Icons.flight_takeoff_outlined,
                    size: 48, color: black),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 28,
                ),
                title: Text(tickets.name, style: kHeading6),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    Text(
                      tickets.routes + ' | ' + tickets.location,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text('Rp. ${tickets.price}'),
                  ],
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
      child: Scaffold(
        backgroundColor: backgroundPrimary2,
        body: _listTickets(context),
      ),
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
      child: Scaffold(
        backgroundColor: backgroundPrimary2,
        body: _listBooked(context),
      ),
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
    return Consumer<TripDatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBooked(trip.id),
          builder: (context, snapshot) {
            return Material(
              color: backgroundPrimary2,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: Hero(
                    tag: trip.photoUrl!,
                    child: CachedNetworkImage(
                      imageUrl: trip.photoUrl!,
                      alignment: Alignment.center,
                      height: 60,
                      width: 100,
                    ),
                  ),
                  title: Text(trip.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.location),
                      Text('Rp. ${trip.price}'),
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
}
