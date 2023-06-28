import 'package:auropay/services/auth_service.dart';
import 'package:auropay/view/Theme/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../view/pages/Routes.dart';
import 'view/Theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authService = AuthService();
  bool isUserSignedIn = await authService.isUserSignedIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        Provider.value(value: authService),
      ],
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuroPay',
      theme: AppColors.lightTheme, // Use the current theme from the provider
      darkTheme: AppColors.darkTheme,
      themeMode: themeProvider.getThemeMode(), // Use the current theme mode from the provider
      initialRoute: _user != null ? '/signedUser' : '/splashScreen',
      routes: routes,
    );
  }
}
