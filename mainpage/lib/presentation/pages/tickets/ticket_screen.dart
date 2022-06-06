import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:mainpage/presentation/pages/tickets/ticket_list.dart';

part 'bus.dart';
part 'train.dart';
part 'plane.dart';

class TicketSearch extends StatefulWidget {
  const TicketSearch({Key? key}) : super(key: key);

  @override
  State<TicketSearch> createState() => _TicketSearch();
}

class _TicketSearch extends State<TicketSearch> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundPrimary1,
          toolbarHeight: 75,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 30),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mark_email_unread,
                    size: 40, color: backgroundPrimary2),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 30),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications,
                    size: 40, color: backgroundPrimary2),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorWeight: 10,
            indicatorColor: backgroundPrimary2,
            tabs: [
              Tab(
                text: 'Bus',
                icon: Icon(Icons.directions_bus, color: backgroundPrimary2),
              ),
              Tab(
                text: 'Train',
                icon: Icon(Icons.train, color: backgroundPrimary2),
              ),
              Tab(
                text: 'Plane',
                icon: Icon(Icons.flight, color: backgroundPrimary2),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Bus(),
            Train(),
            Plane(),
          ],
        ),
      ),
    );
  }
}
