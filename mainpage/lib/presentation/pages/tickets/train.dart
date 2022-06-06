part of 'ticket_screen.dart';

class Train extends StatefulWidget {
  Train({Key? key}) : super(key: key);

  @override
  State<Train> createState() => _Train();
}

class _Train extends State<Train> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'Bandung (BDG)',
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
                  hintText: 'Surabaya (SBY)',
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
              child: Text('Time', style: kHeading6),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.timelapse,
                        size: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Text(
                        '${selectedTime.hour} : ${selectedTime.minute}',
                        style: kHeading6,
                      ),
                    ],
                  ),
                ),
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
                onPressed: () => const SnackBar(content: Text('Coming Soon')),
                child: Text('Search Tickets', style: button),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shadowColor: Colors.black,
                  primary: backgroundPrimary1,
                  minimumSize: const Size(175, 60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
