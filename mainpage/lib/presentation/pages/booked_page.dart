import 'package:core/styles/colors.dart';
import 'package:flutter/material.dart';

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

  final String img =
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.oGNH9MlCWNWOEUSwnT51ewHaFV%26pid%3DApi&f=1";
  final String date = "Jumat, 22 Agustus 2022";
  final String time = "14:04";
  final String title = "South East America";
  final double rating = 4.4;
  final String price = "Rp. 20.000,00";
  final bool booked = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        // child: Image.network(
                        //   img,
                        //   width: 80.0,
                        //   height: 80.0,
                        // ),
                        //   child: Container(
                        //     decoration: const BoxDecoration(
                        //       color: backgroundPrimary1,
                        //     ),
                        //     width: 80.0,
                        //     height: 80.0,
                        //     margin: const EdgeInsets.all(8.0),
                        //   ),
                        child: const Placeholder(
                          fallbackWidth: 80,
                          fallbackHeight: 80,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(date),
                          Text(time),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber[400],
                              ),
                              Text(rating.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.price_change,
                                color: Colors.amber[400],
                              ),
                              Text(price),
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
