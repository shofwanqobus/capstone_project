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
                onPressed: () {
                  Navigator.pushNamed(context, detailPage);
                },
                icon: const Icon(Icons.notifications,
                    size: 40, color: backgroundPrimary2)),
          ),
        ],
      ),
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
                    onPressed: () => Navigator.pushNamed(context, ticketSearch),
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
                'Popular',
                style: kHeading6,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                  itemBuilder: (context, index) {
                    return buildCard(index);
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Recent Places',
                style: kHeading6,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                  itemBuilder: (context, index) {
                    return buildCard(index);
                  },
                ),
              ),
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

  Widget buildCard(int index) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: backgroundPrimary1,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Floating Market Lembang', style: kBodyText),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber[400],
                      ),
                      Text('4.6', style: kBodyText),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.price_change, color: Colors.amber[400]),
                      Text('Rp. 124.999/pax', style: kBodyText),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
