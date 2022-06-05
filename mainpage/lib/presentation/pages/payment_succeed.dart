import 'package:flutter/material.dart';
import 'package:core/core.dart';

class PaymentSucceed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      body: Center(
        child: Container(
          height: 325,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: black),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.receipt_rounded,
                  color: backgroundPrimary1, size: 100),
              Text(
                'Success',
                style: kHeading6,
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
                indent: 30,
                endIndent: 30,
              ),
              Text(
                'Kamis, 19 Mei 2022 14:04',
                style: kSubtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              Text(
                'ID: 123456789',
                style: kBodyText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Perlihatkan ID yang diterima kepada Petugas',
                style: kSubtitle,
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, paymentSucceed),
                    child: Text('Status', style: button),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shadowColor: Colors.black,
                      primary: backgroundPrimary1,
                      minimumSize: const Size(50, 50),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, homePage),
                    child: Text('Home', style: button2),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shadowColor: Colors.black,
                      primary: backgroundPrimary2,
                      minimumSize: const Size(50, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
