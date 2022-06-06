part of 'ticket_screen.dart';

class Plane extends StatefulWidget {
  Plane({Key? key}) : super(key: key);

  @override
  State<Plane> createState() => _Plane();
}

class _Plane extends State<Plane> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 6, 6),
    end: DateTime(2022, 6, 13),
  );

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    var selectedValue;
    const seatClass = ['Economy Class', 'Business Class', 'First Class'];

    @override
    void dispose() {
      super.dispose();
      controller.dispose();
    }

    return Scaffold(
      backgroundColor: backgroundPrimary2,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Text('From', style: kHeading6),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                onChanged: (query) {},
                key: const Key('username'),
                decoration: InputDecoration(
                  hintText: 'Indonesia (IDN)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                textInputAction: TextInputAction.send,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Text('To', style: kHeading6),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                onChanged: (query) {},
                key: const Key('username'),
                decoration: InputDecoration(
                  hintText: 'Los Angeles (LA)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                textInputAction: TextInputAction.send,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date Departure and Return',
                    style: kHeading6,
                  ),
                  TextField(
                    readOnly: true,
                    controller: controller,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.date_range, color: backgroundPrimary1),
                    ),
                    onTap: () async {
                      DateTimeRange? newDateRange = await showDateRangePicker(
                        context: context,
                        initialDateRange: dateRange,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      controller.text = newDateRange.toString();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Seat Class',
                    style: kHeading6,
                  ),
                  //References : https://flutteragency.com/how-to-solve-dropdown-selection-is-not-displaying-in-flutter/
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Select Seat Class', style: kBodyText),
                              value: selectedValue,
                              isDense: true,
                              onChanged: (newValue) => setState(
                                () {
                                  selectedValue = newValue;
                                },
                              ),
                              items: seatClass.map(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                },
                              ).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Passengers',
                    style: kHeading6,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.airline_seat_recline_extra,
                          color: backgroundPrimary1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 229, 229, 229),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, ticketList),
                child: Text('Search Tickets', style: button),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shadowColor: Colors.black,
                  primary: backgroundPrimary1,
                  minimumSize: const Size(175, 60),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
