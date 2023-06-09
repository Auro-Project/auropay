import 'package:auropay/view/pages/LoginScreens/ConfirmOTPScreenD.dart';
import 'package:auropay/view/pages/LoginScreens/LoginScreen.dart';
import 'package:auropay/view/pages/LoginScreens/LoginScreenD.dart';
import 'package:auropay/view/pages/LoginScreens/SignUpScreenD.dart';
import 'package:auropay/view/pages/LoginScreens/SignedUserScreen.dart';
import 'package:auropay/view/pages/LoginScreens/passcode/CodeScreen.dart';
import 'package:auropay/view/pages/MoreScreens/ContactScreen.dart';
import 'package:auropay/view/pages/MoreScreens/HelpScreen.dart';
import 'package:auropay/view/pages/MoreScreens/MoreScreen.dart';
import 'package:auropay/view/pages/MoreScreens/NotificationScreen.dart';
import 'package:auropay/view/pages/MoreScreens/NotificationScreen1.dart';
import 'package:auropay/view/pages/MoreScreens/ProfileScreen.dart';
import 'package:auropay/view/pages/MoreScreens/SettingScreen.dart';
import 'package:auropay/view/pages/MoreScreens/SupportScreen.dart';
import 'package:auropay/view/pages/QR%20Code/QRCodeScreen.dart';
import 'package:auropay/view/pages/ReceiptScreen.dart';
import 'package:auropay/view/pages/Send/SendScreen.dart';
import 'package:auropay/view/pages/Send/TopUpScreen.dart';
import 'package:auropay/view/pages/SplashScreen.dart';
import 'package:auropay/view/pages/TransactionScreen.dart';
import 'package:auropay/view/pages/onBoardScreen.dart';
import 'package:auropay/view/pages/providers/theme_provider.dart';
import 'package:auropay/view/pages/FutureEnhancements/AnalyticsScreen.dart';
import 'package:auropay/view/pages/HomeScreen.dart';
import 'package:auropay/view/pages/LoginScreens/AccountScreen.dart';
import 'package:auropay/view/pages/Send/ConfirmPayScreen.dart';
import 'package:auropay/view/pages/Send/ProgressScreen.dart';
import 'package:auropay/view/pages/Send/SuccessScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// void main() async {
//   // Initialize Firebase
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness: Brightness.dark,
//     ),
//   );
//
//   runApp(
//     ChangeNotifierProvider<ThemeProvider>(
//       create: (_) => ThemeProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
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
            home: const SignedUserScreen(),
            routes: {
              '/onBoarding': (context) => const OnBoardingScreen(),
              '/signedUser' : (context) => const SignedUserScreen(),
              '/account': (context) => const AccountScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/confirmOTP': (context) =>  ConfirmOTPScreen(phoneNumber: '', countryCode: '', verificationId: '', onVerificationComplete: (PhoneAuthCredential ) {  },),
              '/createPasscode' : (context) =>  const CreatePasscodeScreen(),
              '/confirmPasscode': (context) => const ConfirmPasscodeScreen(),
              '/home': (context) => const HomeScreen(),
              '/topup' : (context) =>  PaymentTopUpScreen(),
              '/qrscreen': (context) => const QRScreen(),
              '/confirmpay': (context) => const ConfirmPayScreen(),
              '/progress': (context) => const ProgressScreen(),
              '/success': (context) => const SuccessScreen(),
              '/receipt': (context) => ReceiptScreen(),
              '/transactions': (context) => const TransactionScreen(),
              '/analytics': (context) =>  AnalyticsScreen(),
              '/more': (context) => const MoreScreen(),
              '/profile' : (context) => const ProfileScreen(),
              '/help' : (context) => const HelpScreen(),
              '/support' : (context) => const SupportScreen(),
              '/contact' : (context) => const ContactScreen(),
              '/settings' : (context) => const SettingScreen(),
              '/notifications' : (context) => const NotificationScreen(),
              '/notifs' : (context) => const NotifScreen(),
              '/send': (context) => const SendScreen(),
            },
          );
        }
    );
  }
}