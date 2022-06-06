import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:mainpage/mainpage.dart';

class TicketList extends StatefulWidget {
  const TicketList({Key? key}) : super(key: key);
  static const ticketList = '/ticket-list';

  @override
  State<TicketList> createState() => _TicketList();
}

class _TicketList extends State<TicketList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      backgroundColor: backgroundPrimary2,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                alignment: Alignment.centerLeft,
                height: 100,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: black),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Text('Indonesia -> Los Angeles',
                              style: kSubtitle),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Text('2 Passengers | Business Class',
                              style: kSubtitle),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Monday, May 22 2022',
                        style: kSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 229, 229, 229),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 9,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.NYngvQQW1fRwQkUE080elAHaHa%26pid%3DApi&f=1",
                            ),
                            radius: 35,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Garuda Airlines', style: kHeading6),
                              Text('10:42 a.m.', style: kBodyText),
                              Text('Bandara Soekarno-Hatta', style: kBodyText),
                            ],
                          ),
                          const SizedBox(width: 50),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () =>
                                    Navigator.pushNamed(context, paymentScreen),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: backgroundPrimary1,
                                  ),
                                  child: Text('Buy', style: textButton2),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('Rp. 801.221/pax',
                                  style: kSubtitle,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 229, 229, 229),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
