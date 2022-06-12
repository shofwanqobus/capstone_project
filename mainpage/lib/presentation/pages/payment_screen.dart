import 'package:flutter/material.dart';
import 'package:core/core.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPage createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  TextEditingController controller = TextEditingController();
  int? _radioValue = 1;
  int administration = 5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      appBar: AppBar(
        backgroundColor: backgroundPrimary2,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Payment Verification', style: kHeading6),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 229, 229, 229),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, bottom: 8),
              child: Text('Payment Method', style: kSubtitle),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 24, bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('GoPay', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('OVO', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 3,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('ShopeePay', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 4,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('DANA', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 5,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('Alfamart', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 6,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('ATM/Virtual Bank', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 7,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('Visa', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 8,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('PayPal', style: kSubtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 9,
                        groupValue: _radioValue,
                        onChanged: (value) =>
                            setState(() => _radioValue = value as int),
                      ),
                      Text('Indomaret', style: kSubtitle),
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Payment Detail', style: kSubtitle),
            ),
            Center(
              child: Container(
                height: 150,
                width: 300,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Subtotal Order', style: kBodyText),
                        Text('Rp. 249.998', style: kBodyText),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Administration', style: kBodyText),
                        Text('Rp. $administration', style: kBodyText),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Total Payment', style: kSubtitle),
                        Text('Rp. 254.998', style: kSubtitle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Payment',
                    style: kBodyText,
                    textAlign: TextAlign.left,
                  ),
                  Text('Rp. 254.998,-', style: kHeading6),
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, paymentSucceed),
                child: Text('Pay', style: button),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shadowColor: Colors.black,
                  primary: backgroundPrimary1,
                  minimumSize: const Size(100, 100),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
