import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //this line for add firebase
  await Firebase.initializeApp();
  //this line for the language
  await Settings.init(cacheProvider: SharePreferenceCache());
  await FirebaseAuth.instance.setLanguageCode('en');
  // String? token = await FirebaseMessaging.instance.getToken();
  //print("the token of device : $token");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      home: const IntroPage(),
    );
  }
}
