import 'package:flutter/material.dart';
import 'package:core/core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: AppBar(
        backgroundColor: backgroundPrimary1,
        toolbarHeight: 75,
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
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(),
            ),
          ],
        ),
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
