import 'package:auropay/view/pages/LoginScreens/LoginScreen.dart';
import 'package:auropay/view/pages/LoginScreens/SignUpScreen.dart';
import 'package:auropay/view/pages/MoreScreens/ContactScreen.dart';
import 'package:auropay/view/pages/MoreScreens/HelpScreen.dart';
import 'package:auropay/view/pages/MoreScreens/MoreScreen.dart';
import 'package:auropay/view/pages/MoreScreens/NotificationScreen.dart';
import 'package:auropay/view/pages/MoreScreens/ProfileScreen.dart';
import 'package:auropay/view/pages/MoreScreens/SettingScreen.dart';
import 'package:auropay/view/pages/MoreScreens/SupportScreen.dart';
import 'package:auropay/view/pages/ReceiptScreen.dart';
import 'package:auropay/view/pages/Send/SendScreen.dart';
import 'package:auropay/view/pages/SplashScreen.dart';
import 'package:auropay/view/pages/TransactionScreen.dart';
import 'package:auropay/view/pages/onBoardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:auropay/view/pages/providers/theme_provider.dart';
import 'package:auropay/view/pages/AnalyticsScreen.dart';
import 'package:auropay/view/pages/HomeScreen.dart';
import 'package:auropay/view/pages/LoginScreens/AccountScreen.dart';
import 'package:auropay/view/pages/QR Code/QRCodeScreen1.dart';
import 'package:auropay/view/pages/Send/ConfirmPayScreen.dart';
import 'package:auropay/view/pages/Send/ProgressScreen.dart';
import 'package:auropay/view/pages/Send/SuccessScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
        builder: (context,child) {
          final provider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AuroPay',
            theme: provider.theme,
            home: const SplashScreen(),
            routes: {
              '/onBoarding': (context) => const OnBoardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/home': (context) => const HomeScreen(),
              '/transactions': (context) => const TransactionScreen(),
              '/analytics': (context) => const AnalyticsScreen(),
              '/more': (context) => const MoreScreen(),
              '/send': (context) => const SendScreen(),
              '/progress': (context) => const ProgressScreen(),
              '/success': (context) => const SuccessScreen(),
              '/account': (context) => const AccountScreen(),
              '/qrscreen': (context) => const QRCodeScreen(),
              '/confirmpay': (context) => const ConfirmPayScreen(),
              '/receipt': (context) => ReceiptScreen(),
              '/profile' : (context) => const ProfileScreen(),
              '/help' : (context) => const HelpScreen(),
              '/support' : (context) => const SupportScreen(),
              '/contact' : (context) => const ContactScreen(),
              '/settings' : (context) => const SettingScreen(),
              '/notifications' : (context) => const NotificationScreen(),
            },
          );
        }
    );
  }
}
