import 'package:auropay/view/Theme/appColors.dart';

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
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AuroPay',
          theme: AppColors.lightTheme,
          darkTheme: AppColors.darkTheme,
          themeMode: themeProvider.currentTheme,
          home: const SplashScreen(),
          routes: routes, // Use the routes from the routes.dart file
        );
      },
    );
  }
}
