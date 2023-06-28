import 'package:auropay/view/pages/LoginScreens/ConfirmOTP.dart';
import 'package:auropay/view/pages/LoginScreens/LoginScreen.dart';
import 'package:auropay/view/pages/LoginScreens/SignUpInfo.dart';
import 'package:auropay/view/pages/LoginScreens/SignedUserScreen.dart';
import 'package:auropay/view/pages/LoginScreens/passcode/PasscodeScreen.dart';
import 'package:auropay/view/pages/MoreScreens/ContactScreen.dart';
import 'package:auropay/view/pages/MoreScreens/FAQScreen.dart';
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
import 'package:auropay/view/pages/Send/WithdrawScreen.dart';
import 'package:auropay/view/pages/SplashScreen.dart';
import 'package:auropay/view/pages/TransactionScreen.dart';
import 'package:auropay/view/pages/onBoardScreen.dart';
import 'package:auropay/view/pages/FutureEnhancements/AnalyticsScreen.dart';
import 'package:auropay/view/pages/HomeScreen.dart';
import 'package:auropay/view/pages/AccountScreen.dart';
import 'package:auropay/view/pages/Send/ConfirmPayScreen.dart';
import 'package:auropay/view/pages/Send/ProgressScreen.dart';
import 'package:auropay/view/pages/Send/SuccessScreen.dart';
import 'package:flutter/material.dart';
import 'FutureEnhancements/DesignCardScreen.dart';
import 'MoreScreens/PrivacyPolicyScreen.dart';
import 'MoreScreens/SecurityScreen.dart';

final Map<String, WidgetBuilder> routes = {
  '/splashScreen': (context) => const SplashScreen(),
  '/onBoarding': (context) => const OnBoardingScreen(),
  '/signedUser': (context) => const SignedUserScreen(),
  '/account': (context) => const AccountScreen(),
  '/login': (context) => const LoginScreen(),
  // '/signup': (context) => const SignUpScreen(),
  '/signup': (context) =>  SignupInfoScreen(),

  '/createPasscode': (context) => const CreatePasscodeScreen(),
  '/confirmPasscode': (context) => const ConfirmPasscodeScreen(),
  '/home': (context) => const HomeScreen(),
  '/topup': (context) => PaymentTopUpScreen(),
  '/withdraw': (context) =>  WithdrawalScreen(),
  '/qrscreen': (context) => const ScannerView(),
  '/confirmpay': (context) => const ConfirmPayScreen(),
  '/progress': (context) => const ProgressScreen(),
  '/success': (context) => const SuccessScreen(),
  '/receipt': (context) => ReceiptScreen(),
  '/transactions': (context) => const TransactionScreen(),
  '/analytics': (context) => AnalyticsScreen(),
  '/more': (context) => const MoreScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/support': (context) => const SupportScreen(),
  '/contact': (context) => const ContactScreen(),
  '/settings': (context) => const SettingScreen(),
  '/notifications': (context) => const NotificationScreen(),
  '/notifs': (context) => const NotifScreen(),
  '/send': (context) => const SendScreen(),
  '/designcard': (context) =>  DesignCardScreen(),
  '/security' : (context) => const SecurityScreen(),
  '/policy': (context) => const PolicyScreen(),
  '/faq' : (context) => const FAQScreen()
};
