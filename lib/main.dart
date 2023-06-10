import 'package:auropay/view/Theme/appColors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../view/pages/Routes.dart';
import '../../../view/pages/SplashScreen.dart';
import 'view/Theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final storage = FlutterSecureStorage();
  String? isSignedIn = await storage.read(key: 'isSignedIn');
  bool isUserSignedIn = isSignedIn != null && isSignedIn == true;

  runApp(MyApp(isUserSignedIn: isUserSignedIn));

  // runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isUserSignedIn;
  const MyApp({Key? key, required this.isUserSignedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AuroPay',
          theme: AppColors.lightTheme,
          darkTheme: AppColors.darkTheme,
          themeMode: themeProvider.currentTheme,
          // home: const SplashScreen(),
          initialRoute: isUserSignedIn ? '/signedUser' : '/splashScreen',
          routes: routes, // Use the routes from the routes.dart file
        );
      },
    );
  }
}

