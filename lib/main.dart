import 'package:auropay/view/Theme/appColors.dart';
import 'package:device_preview/device_preview.dart';
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
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBkyFiXnScJEbnZGiuN9BRKyPYxy83wcgA",
        authDomain: "auropay-47531.firebaseapp.com",
        databaseURL: "https://auropay-47531-default-rtdb.firebaseio.com",
        projectId: "auropay-47531",
        storageBucket: "auropay-47531.appspot.com",
        messagingSenderId: "475540638444",
        appId: "1:475540638444:web:23f2abc194cd1840f533c9",
        measurementId: "G-GNBRJCX941"
    )
  );

  final storage = FlutterSecureStorage();
  String? isSignedIn = await storage.read(key: 'isSignedIn');
  bool isUserSignedIn = isSignedIn != null && isSignedIn == 'false';



  // runApp(
  //     MyApp(isUserSignedIn: isUserSignedIn)
  // );
  runApp(
    DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools,
        // const CustomPlugin(),
      ],
      builder: (context) => MyApp(isUserSignedIn: isUserSignedIn),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
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
          initialRoute: _user != null ? '/signedUser' : '/splashScreen',
          routes: routes,
        );
      },
    );
  }
}
