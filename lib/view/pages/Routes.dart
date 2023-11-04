import '../../../view/pages/LoginScreens/LoginScreen.dart';
import '../../../view/pages/LoginScreens/SignUpInfo.dart';
import '../../../view/pages/LoginScreens/SignedUserScreen.dart';
import '../../../view/pages/LoginScreens/passcode/PasscodeScreen.dart';
import '../../../view/pages/MoreScreens/ContactScreen.dart';
import '../../../view/pages/MoreScreens/FAQScreen.dart';
import '../../../view/pages/MoreScreens/MoreScreen.dart';
import '../../../view/pages/MoreScreens/NotificationScreen.dart';
import '../../../view/pages/MoreScreens/NotificationsScreen.dart';
import '../../../view/pages/MoreScreens/ProfileScreen.dart';
import '../../../view/pages/MoreScreens/SettingScreen.dart';
import '../../../view/pages/MoreScreens/SupportScreen.dart';
import '../../../view/pages/QR%20Pay/QRPayScreen.dart';
import '../../../view/pages/ReceiptScreen.dart';
import '../../../view/pages/Send/SendScreen.dart';
import '../../../view/pages/Send/TopUpScreen.dart';
import '../../../view/pages/Send/WithdrawScreen.dart';
import '../../../view/pages/SplashScreen.dart';
import '../../../view/pages/TransactionScreen.dart';
import '../../../view/pages/onBoardScreen.dart';
import '../../../view/pages/FutureEnhancements/AnalyticsScreen.dart';
import '../../../view/pages/HomeScreen.dart';
import '../../../view/pages/AccountScreen.dart';
import '../../../view/pages/Send/ConfirmPayScreen.dart';
import '../../../view/pages/Send/ProgressScreen.dart';
import '../../../view/pages/Send/SuccessScreen.dart';
import 'package:flutter/material.dart';
import '../../../view/pages/FutureEnhancements/DesignCardScreen.dart';
import '../../../view/pages/MoreScreens/PrivacyPolicyScreen.dart';
import '../../../view/pages/MoreScreens/SecurityScreen.dart';

final Map<String, WidgetBuilder> routes = {
  '/splashScreen': (context) => const SplashScreen(),
  '/onBoarding': (context) => const OnBoardingScreen(),
  '/signedUser': (context) => const SignedUserScreen(),
  '/account': (context) => const AccountScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) =>  const SignupInfoScreen(),
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
  '/notifs': (context) => const NotificationsScreen(),
  '/send': (context) => const SendScreen(),
  '/designcard': (context) =>  const DesignCardScreen(),
  '/security' : (context) => const SecurityScreen(),
  '/policy': (context) => const PolicyScreen(),
  '/faq' : (context) => const FAQScreen()
};
