
import 'package:auropay/view/Theme/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../responsive_widget.dart';
import '../../widgets/Constants.dart';
import '../../Theme/theme_provider.dart';

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

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false);
    // Perform any other sign-out related actions
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color(0xFFDBDEF3),
          //       Color(0xFF99ADEF),
          //     ],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          // ),
          height: height,
          width: width,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/shapes/gradHM.png',
                width: MediaQuery.of(context).size.width,
              ),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  ResponsiveWidget.isMediumScreen(context) ?  Container() : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(
                        //   'assets/images/icons/Logo.svg',
                        //   width: 100,
                        //   height: 100,
                        //   color: Colors.white.withOpacity(0.8),
                        // ),s
                        Image.asset(
                          'assets/images/pscode.png',
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Hello, Sneha!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SF Pro Display',
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 60),
                        const Text(
                          'Enter your MPIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'SF Pro Display',
                            color: AppColors.textColor,
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
                                  style: const TextStyle(
                                    color: AppColors.textColor,
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
                            child: const Text('Forgot MPIN?',style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'SF Pro Display',
                              color: AppColors.accent1,
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
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Use Face ID',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'SF Pro Display',
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

