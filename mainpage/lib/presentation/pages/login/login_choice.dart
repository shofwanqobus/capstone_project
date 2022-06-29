import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({Key? key}) : super(key: key);

  @override
  _LoginChoice createState() => _LoginChoice();
}

class _LoginChoice extends State<LoginChoice> {
  final _db = FirebaseFirestore.instance;

  bool _googleLoading = false;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary2,
      body: Column(
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: backgroundPrimary1,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 16, left: 28, right: 28),
                  child: Text(
                    'Welcome',
                    style: kHeading4,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  child: Text(
                    'Spend your holiday only with one click, and enjoy your trip',
                    style: textButton2,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 125),
          Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    try {
                      setState(() => _googleLoading = true);

                      await googleSignIn.signOut();

                      final googleUser = await googleSignIn.signIn();

                      if (googleUser == null) {
                        setState(() => _googleLoading = false);

                        return;
                      }

                      _user = googleUser;

                      final googleAuth = await googleUser.authentication;
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );

                      final db = FirebaseFirestore.instance;
                      final prefs = await SharedPreferences.getInstance();

                      final docRef =
                          db.collection("users").doc(googleUser.email);

                      docRef.get().then(
                        (DocumentSnapshot doc) async {
                          final data = doc.data() as Map<String, dynamic>;

                          if (data != null) {
                            print("User ${googleUser.email} already exist");
                          }
                        },
                        // onError: (e) => print("Error getting document: $e"),
                      ).catchError((e) async {
                        print(
                            "debug: user data is not in database, creating...");

                        final insertUser = <String, dynamic>{
                          "id": googleAuth.idToken,
                          "photoUrl": googleUser.photoUrl,
                          "provider": "google",
                          "username": googleUser.displayName,
                          "email": googleUser.email,
                          "phoneNumber": null,
                          "dateOfBirth": null,
                          "booked": {
                            "hotels": [],
                            "trips": [],
                            "tickets": [],
                          },
                          "favorites": {
                            "hotels": [],
                            "trips": [],
                          },
                          "reviews": {
                            "hotels": [],
                            "trips": [],
                          },
                          "recentPlaces": [],
                          "totalTrip": 0,
                          "points": 0,
                          "member": "bronze",
                        };

                        await prefs.setString("data", json.encode(insertUser));

                        _db
                            .collection("users")
                            .doc(googleUser.email)
                            .set(insertUser);

                        const SnackBar(
                          content:
                              Text("debug: user data successfully created"),
                        );
                      });

                      docRef.get().then(
                        (DocumentSnapshot doc) async {
                          final data = doc.data() as Map<String, dynamic>;
                          await prefs.setString("data", json.encode(data));

                          final favTrips = data["favorites"]["trips"];
                          final favHotels = data["favorites"]["hotels"];

                          final bookedHotels = data["booked"]["hotels"];
                          final bookedTrips = data["booked"]["trips"];
                          final bookedTickets = data["booked"]["tickets"];

                          DatabaseHelper _databaseHelper = DatabaseHelper();

                          await _databaseHelper.clearcache();

                          if (favTrips is String) {
                            await _databaseHelper.setFavoriteTrips(favTrips);
                          }

                          if (favHotels is String) {
                            await _databaseHelper.setFavoriteHotels(favHotels);
                          }

                          if (bookedHotels is String) {
                            await _databaseHelper.setBookedHotels(bookedHotels);
                          }

                          if (bookedTrips is String) {
                            await _databaseHelper.setBookedTrips(bookedTrips);
                          }

                          if (bookedTickets is String) {
                            await _databaseHelper
                                .setBookedTickets(bookedTickets);
                          }
                        },
                        // onError: (e) => print("Error getting document: $e"),
                      );

                      await FirebaseAuth.instance
                          .signInWithCredential(credential);

                      print('signed in!');
                      Navigator.pushNamed(context, homePage);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 245,
                    height: 55,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: _googleLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Center(child: CircularProgressIndicator()),
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.g_mobiledata,
                                color: Colors.black,
                                size: 40,
                              ),
                              const SizedBox(width: 12),
                              Text('Login with Google', style: kSubtitle),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, logInAccount),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 245,
                    height: 55,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.supervisor_account,
                          color: Colors.black,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Text('Login with Account', style: kSubtitle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();

                    prefs.setBool("signup-from-signin", false);

                    Navigator.pushNamed(context, signUpAccount);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 245,
                    height: 55,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.supervised_user_circle,
                          color: Colors.black,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Text('Sign Up Account', style: kSubtitle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
