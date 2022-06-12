import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mainpage/data/models/plane_ticket_model.dart';
import 'package:mainpage/presentation/pages/home_page.dart';

class Plane extends StatelessWidget {
  const Plane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      backgroundColor: backgroundPrimary2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_ticket_pesawat.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> jsonMap = jsonDecode(snapshot.data!);
                    final ticketItem = PlaneTicketModel.fromJson(jsonMap);

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: ticketItem.tickets.length,
                      itemBuilder: (context, index) {
                        return _listTickets(context, ticketItem.tickets[index]);
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

  Widget _listTickets(BuildContext context, PlaneTicketItems tickets) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tickets.name, style: kHeading6),
                  Text(tickets.routes, style: kBodyText),
                  Text(tickets.location, style: kBodyText),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, paymentScreen),
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
                  Text('Rp. ${tickets.price!}',
                      style: kSubtitle, textAlign: TextAlign.center),
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
  }
}
