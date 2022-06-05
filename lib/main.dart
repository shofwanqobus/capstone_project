import 'package:core/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:login/login.dart';
import 'package:mainpage/mainpage.dart';
import 'package:mainpage/presentation/pages/trip_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: splashScreen,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case splashScreen:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case logInChoice:
            return MaterialPageRoute(builder: (_) => const LoginChoice());
          case signUpAccount:
            return MaterialPageRoute(builder: (_) => const SignUpAccount());
          case logInAccount:
            return MaterialPageRoute(builder: (_) => const LoginAccount());
          case homePage:
            return MaterialPageRoute(builder: (_) => const HomePage());
          case detailPage:
            return MaterialPageRoute(builder: (_) => DetailPage());
          case paymentScreen:
            return MaterialPageRoute(builder: (_) => const PaymentPage());
          case paymentSucceed:
            return MaterialPageRoute(builder: (_) => PaymentSucceed());
          case tripDetail:
            return MaterialPageRoute(builder: (_) => TripDetailPage());
          case ticketSearch:
            return MaterialPageRoute(builder: (_) => const TicketSearch());
        }
      },
    );
  }
}
