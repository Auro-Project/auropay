import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Theme/appColors.dart';
import '../../../widgets/AppButtons.dart';
import '../../../widgets/Constants.dart';
import '../../../widgets/CustomError.dart';
import '../../../Theme/theme_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../HomeScreen.dart';

class CreatePasscodeScreen extends StatefulWidget {
  const CreatePasscodeScreen({Key? key}) : super(key: key);

  @override
  _CreatePasscodeScreenState createState() => _CreatePasscodeScreenState();
}

class _CreatePasscodeScreenState extends State<CreatePasscodeScreen> {
  List<TextEditingController> passcodeControllers = [];
  int currentPasscodeIndex = 0;
  final storage = const FlutterSecureStorage();

  void savePasscode() async {
    String passcode =
        passcodeControllers.map((controller) => controller.text).join();
    await storage.write(key: 'passcode', value: passcode);
  }

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

  void focusNextPasscodeField() {
    if (currentPasscodeIndex < passcodeControllers.length - 1) {
      currentPasscodeIndex++;
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Create Passcode', showLeadingIcon: false),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a secure passcode you can use to log in \nto your app anytime.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SF Pro Display',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                            if (value.isNotEmpty) {
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
              ],
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OutlinedButton(
                onPressed: () {
                  // Add your code here for the action when the button is pressed
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.deepPurpleAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(250, 60),
                ),
                child: const Text(
                  'Use Thumb/Face ID',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SF Pro Display',
                    color: Colors.deepPurpleAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child:
                    // appButton(context, gradient(context), 'Proceed', '/confirmPasscode'),
                    appButtonFunc(context, gradient(context), 'Proceed', () {
                  savePasscode();
                  Navigator.pushNamed(context, '/confirmPasscode');
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmPasscodeScreen extends StatefulWidget {
  const ConfirmPasscodeScreen({Key? key}) : super(key: key);

  @override
  _ConfirmPasscodeScreenState createState() => _ConfirmPasscodeScreenState();
}

class _ConfirmPasscodeScreenState extends State<ConfirmPasscodeScreen> {
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
    String passcode =
        passcodeControllers.map((controller) => controller.text).join();
    String? savedPasscode = await storage.read(key: 'passcode');
    return passcode == savedPasscode;
  }

  Future<void> signIn(String email, String password) async {
    // This is just an example, your actual sign-in code may look different
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    // When sign-in is successful, save to secure storage
    await FlutterSecureStorage().write(key: 'isSignedIn', value: 'true');
  }

  void focusNextPasscodeField() {
    if (currentPasscodeIndex < passcodeControllers.length - 1) {
      currentPasscodeIndex++;
      FocusScope.of(context).nextFocus();
    }
  }

  void navigateToHomeScreen() async {
    if (await confirmPasscode()) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      // Show an error message to the user
      showGlobalSnackBar(context, 'Invalid passcode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Confirm Passcode', showLeadingIcon: false),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a secure passcode you can use to log in \nto your app anytime.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SF Pro Display',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                            if (value.isNotEmpty) {
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
              ],
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: appButtonFunc(context, gradient(context), 'Done',
                      navigateToHomeScreen)),
            ),
          ),
        ],
      ),
    );
  }
}
