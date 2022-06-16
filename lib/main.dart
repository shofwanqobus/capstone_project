import 'package:core/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:mainpage/mainpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/presentation/provider/database_provider.dart';
import 'package:mainpage/presentation/provider/favorited_database_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FavDatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: MaterialApp(
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
              return MaterialPageRoute(
                builder: (_) => DetailPage(
                  hotel: ModalRoute.of(context)?.settings.arguments
                      as HotelItemsModel,
                ),
                settings: settings,
              );
            case planeTicket:
              return MaterialPageRoute(builder: (_) => const Plane());
            case searchPage:
              return MaterialPageRoute(builder: (_) => const SearchPage());
            case bookedPage:
              return MaterialPageRoute(builder: (_) => const BookedPage());
            case userPage:
              return MaterialPageRoute(builder: (_) => const UserPage());
            case settingsPage:
              return MaterialPageRoute(builder: (_) => const SettingsPage());

            case settingsLanguage:
              return MaterialPageRoute(
                  builder: (_) => const SettingsLanguage());
            case settingsChangeAccount:
              return MaterialPageRoute(
                builder: (_) => const SettingsChangeAccount(),
              );
            case settingsAccount:
              return MaterialPageRoute(builder: (_) => const SettingsAccount());
            case settingsPasswordConfirmation:
              return MaterialPageRoute(
                builder: (_) => const SettingsPasswordConfirmation(),
              );
            case settingsSchedule:
              return MaterialPageRoute(
                  builder: (_) => const SettingsSchedule());
            case settingsTheme:
              return MaterialPageRoute(builder: (_) => const SettingsTheme());

            case settingsAccountUsername:
              return MaterialPageRoute(
                builder: (_) => const SettingsAccountChangeUsername(),
              );
            case settingsAccountPhoneNumber:
              return MaterialPageRoute(
                builder: (_) => const SettingsAccountChangePhoneNumber(),
              );
            case settingsAccountPassword:
              return MaterialPageRoute(
                builder: (_) => const SettingsAccountChangePassword(),
              );
            case settingsAccountDateOfBirth:
              return MaterialPageRoute(
                builder: (_) => const SettingsAccountChangeDateOfBirth(),
              );

            case userFavorite:
              return MaterialPageRoute(
                builder: (_) => const UserFavorite(),
              );
            case userRecentPlaces:
              return MaterialPageRoute(
                builder: (_) => const UserRecentPlaces(),
              );
            case userChangePoints:
              return MaterialPageRoute(
                builder: (_) => const UserChangePoints(),
              );
            case userReviews:
              return MaterialPageRoute(
                builder: (_) => const UserReviews(),
              );
            case userReview:
              return MaterialPageRoute(
                builder: (_) => const UserReview(),
              );
          }
          return null;
        },
      ),
    );
  }
}
