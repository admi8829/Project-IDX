import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'login_screen.dart';

void main() async {
  // Ensure Flutter engine is fully bootstrapped prior to initializing third-party plugins
  WidgetsFlutterBinding.ensureInitialized();
  
  // Safely initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia & Quiz Universe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

