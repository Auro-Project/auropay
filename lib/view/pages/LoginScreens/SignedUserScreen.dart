
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../widgets/Constants.dart';
import '../providers/theme_provider.dart';

class SignedUserScreen extends StatefulWidget {
  const SignedUserScreen({Key? key}) : super(key: key);

  @override
  _SignedUserScreenState createState() => _SignedUserScreenState();
}

class _SignedUserScreenState extends State<SignedUserScreen> {
  List<TextEditingController> passcodeControllers = [];
  int currentPasscodeIndex = 0;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      passcodeControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in passcodeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<bool> confirmPasscode() async {
    String passcode = passcodeControllers.map((controller) => controller.text).join();
    String? savedPasscode = await storage.read(key: 'passcode');
    return passcode == savedPasscode;
  }

  void focusNextPasscodeField() {
    if (currentPasscodeIndex < passcodeControllers.length - 1) {
      currentPasscodeIndex++;
      FocusScope.of(context).nextFocus();
    }
  }

  void checkPasscode(int index, String value) async {
    if (index == 3 && value.isNotEmpty) { // If it's the last field and it's filled
      if (await confirmPasscode()) {
        Navigator.pushNamed(context, '/home');
      } else {
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid passcode')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7786E8),
              Color(0xFF276AAF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/Logo.svg',
                    width: 100,
                    height: 100,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Hello, Naresh!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro Display',
                      color: Colors.white.withOpacity(0.8),

                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    'Enter your MPIN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'SF Pro Display',
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++)
                        Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: border(context, borderRadius: 15),
                          child: TextField(
                            controller: passcodeControllers[i],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            obscureText: true,
                            style: TextStyle(
                              color: themeProvider.textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              checkPasscode(i, value);
                              if (value.isNotEmpty && i < 3) {
                                focusNextPasscodeField();
                              }
                            },
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: (){},
                      child: Text('Forgot MPIN?',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'SF Pro Display',
                        color: Colors.black.withOpacity(0.7),
                      ),)
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              icon: SvgPicture.asset(
                'assets/images/icons/faceid.svg',
                width: 40,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Use Face ID',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'SF Pro Display',
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

}

