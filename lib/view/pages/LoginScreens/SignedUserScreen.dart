import 'package:auropay/view/Theme/appColors.dart';
import 'package:auropay/view/widgets/CustomError.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/local_auth_api.dart';
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
  bool authenticated = false;

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

  void resetPasscode() async {
    // Clear the existing passcode
    await storage.delete(key: 'passcode');

    // Perform any additional steps required for resetting the passcode

    Navigator.pushReplacementNamed(context, '/createPasscode');
    // Show a success message or navigate to a passcode setup screen
    showGlobalSnackBar(context, 'Now reset your passcode');
  }

  void focusNextPasscodeField() {
    if (currentPasscodeIndex < passcodeControllers.length - 1) {
      currentPasscodeIndex++;
      FocusScope.of(context).nextFocus();
    }
  }

  void checkPasscode(int index, String value) async {
    if (index == 3 && value.isNotEmpty) {
      // If it's the last field and it's filled
      if (await confirmPasscode()) {
        Navigator.pushReplacementNamed(context, '/home');
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/shapes/gradHM.png',
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pscode.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 30),
                       Text(
                        'Hello, Naresh!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF Pro Display',
                         color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 60),
                       Text(
                        'Enter your MPIN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'SF Pro Display',
                         color: Theme.of(context).primaryColor,
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
                                 color: Theme.of(context).primaryColor,
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
                        onPressed: () {
                          resetPasscode();
                        },
                        child: Text(
                          'Forgot MPIN?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'SF Pro Display',
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                IconButton(
                  onPressed: () async {
                    final authenticate = await LocalAuthApi.authenticate();
                    setState(() {
                      authenticated = authenticate;
                    });

                    if (authenticated) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // Authentication failed, display an error message or handle accordingly.
                      showGlobalSnackBar(context, 'Authentication failed');
                    }
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons/faceid.svg',
                    width: 40,
                   color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                 Text(
                  'Use Face ID',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SF Pro Display',
                   color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
