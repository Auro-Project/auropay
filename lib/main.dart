import 'package:auropay/view/Theme/appColors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  bool isUserSignedIn = isSignedIn != null && isSignedIn == 'false';

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(isUserSignedIn: isUserSignedIn),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isUserSignedIn;
  const MyApp({Key? key, required this.isUserSignedIn}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  void checkUserLoggedIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != _user) {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentTheme = themeProvider.getTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuroPay',
      theme: currentTheme, // Use the current theme from the provider
      darkTheme: AppColors.darkTheme,
      themeMode: themeProvider.getThemeMode(), // Use the current theme mode from the provider
      initialRoute: _user != null ? '/signedUser' : '/splashScreen',
      routes: routes,
    );
  }
}
