import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mainpage/data/models/plane_ticket_model.dart';
import 'package:mainpage/presentation/provider/ticket_database_provider.dart';
import 'package:provider/provider.dart';

class Plane extends StatelessWidget {
  const Plane({Key? key}) : super(key: key);

  AppBar ticketsAppBar() {
    return AppBar(
      backgroundColor: backgroundPrimary1,
      toolbarHeight: 75,
      title: const Text("Plane Tickets", style: TextStyle(fontSize: 24.0)),
    );
  }

  Widget _ticket(BuildContext context) {
    return Scaffold(
      appBar: ticketsAppBar(),
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TicketDatabaseProvider>(
      create: (_) => TicketDatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: Scaffold(body: _ticket(context)),
    );
  }

  Widget _listTickets(BuildContext context, PlaneTicketItems tickets) {
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'IDR', symbol: "Rp. ");

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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tickets.name, style: kHeading6),
                    Text(tickets.routes, style: kBodyText),
                    Text(tickets.location, style: kBodyText),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<TicketDatabaseProvider>(
                      builder: (context, provider, child) {
                        return FutureBuilder<bool>(
                          future: provider.isBooked(tickets.id),
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: () => provider.bookedTicket(tickets),
                              child: Text('Buy', style: textButton2),
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                shadowColor: Colors.black,
                                primary: backgroundPrimary1,
                                minimumSize: const Size(80, 40),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currencyFormatter.format(tickets.price!),
                      style: kSubtitle.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
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
