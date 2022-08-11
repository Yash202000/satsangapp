import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:satsangapp/pages/Login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplashScreen(
        splash: const Text(
          "India's #1 Satsung \n  Streaming App",
          style: TextStyle(fontSize: 28),
        ),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const LoginPage(),
        backgroundColor: Colors.white),
  ));
}
