import 'package:transport_app/services/auth_service.dart';

import 'package:transport_app/pages/Auth_Pages/landing_page.dart';

import 'package:transport_app/services/verify_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

// also import your own google-servive-json file.
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "your own api key",
    messagingSenderId: "your own messaging sender id",
    appId: "your own app id",
    projectId: "your own project id",
    storageBucket: "your own storage bucket",
  ));

  runApp(const Transport());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Transport extends StatelessWidget {
  const Transport({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: Utils.messengerKey,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(elevation: 0),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.hasData) {
            return const VerifyPage();
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}
