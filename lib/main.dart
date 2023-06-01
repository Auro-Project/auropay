import 'package:auropay/view/pages/Send/ProgressScreen.dart';
import 'package:auropay/view/pages/Send/SendScreen.dart';
import 'package:auropay/view/pages/Send/SuccessScreen.dart';
import 'package:auropay/view/pages/onBoardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../view/pages/AnalyticsScreen.dart';
import '../../view/pages/HomeScreen.dart';
import '../../view/pages/MoreScreen.dart';
import '../../view/pages/TransactionScreen.dart';
import '../../view/pages/SplashScreen.dart';
import 'dbhelper/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.dark, // Set status bar icons to light color
      statusBarBrightness:
          Brightness.dark, // Set status bar text to light color
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuroPay',
      home: const SplashScreen(),
      routes: {
        '/onBoarding': (context) => const OnBoardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/transactions': (context) => const TransactionScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
        '/more': (context) => const MoreScreen(),
        '/send': (context) => const SendScreen(),
        '/progress': (context) => const ProgressScreen(),
        '/success': (context) => const SuccessScreen(),
      },
    );
  }
}
