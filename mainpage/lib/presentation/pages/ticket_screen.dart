import 'package:flutter/material.dart';
import 'package:core/core.dart';

class TicketSearch extends StatefulWidget {
  const TicketSearch({Key? key}) : super(key: key);

  @override
  _TicketSearch createState() => _TicketSearch();
}

class _TicketSearch extends State<TicketSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: AppBar(
        backgroundColor: backgroundPrimary1,
        toolbarHeight: 75,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 40,
            color: backgroundPrimary2,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mark_email_unread,
                    size: 40, color: backgroundPrimary2)),
          ),
          Container(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications,
                    size: 40, color: backgroundPrimary2)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundPrimary1,
        unselectedLabelStyle: textButton2,
        selectedLabelStyle: textButton2,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: backgroundPrimary2,
            icon: Icon(Icons.home, color: backgroundPrimary2, size: 50),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: backgroundPrimary2,
            icon: Icon(Icons.bookmark_rounded,
                color: backgroundPrimary2, size: 50),
            label: 'Booked',
          ),
          BottomNavigationBarItem(
            backgroundColor: backgroundPrimary2,
            icon: Icon(Icons.supervisor_account_rounded,
                color: backgroundPrimary2, size: 50),
            label: 'User',
          ),
          BottomNavigationBarItem(
            backgroundColor: backgroundPrimary2,
            icon: Icon(Icons.settings, color: backgroundPrimary2, size: 50),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
