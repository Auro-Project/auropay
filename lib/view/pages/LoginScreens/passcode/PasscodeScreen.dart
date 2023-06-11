import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Theme/appColors.dart';
import '../../../widgets/AppButtons.dart';
import '../../../widgets/Constants.dart';
import '../../../widgets/CustomError.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    String passcode = passcodeControllers.map((controller) => controller.text).join();
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
      appBar: myAppBar(context, 'Create Passcode'),
      backgroundColor: AppColors.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth, minHeight: maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Create a secure passcode you can use to log in to your app anytime.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'SF Pro Display',
                          color: AppColors.textColor,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++)
                            Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.symmetric(horizontal: maxWidth * 0.01),
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                      //const SizedBox(height: 20),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
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
                              const SizedBox(height: 10),
                              appButtonFunc(
                                context,
                                gradient(context),
                                'Proceed',
                                    () {
                                  savePasscode();
                                  Navigator.pushNamed(context, '/confirmPasscode');
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
    String passcode = passcodeControllers.map((controller) => controller.text).join();
    String? savedPasscode = await storage.read(key: 'passcode');
    return passcode == savedPasscode;
  }

  Future<void> signIn(String email, String password) async {
    // This is just an example, your actual sign-in code may look different
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    // When sign-in is successful, save to secure storage
    await const FlutterSecureStorage().write(key: 'isSignedIn', value: 'true');
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
      appBar: myAppBar(context, 'Confirm Passcode'),
      backgroundColor: AppColors.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth, minHeight: maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Create a secure passcode you can use to log in to your app anytime.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'SF Pro Display',
                          color: AppColors.textColor,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++)
                            Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.symmetric(horizontal: maxWidth * 0.01),
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                      const SizedBox(height: 50),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              appButtonFunc(
                                context,
                                gradient(context),
                                'Done',
                                    () async {
                                  if (await confirmPasscode()) {
                                    Navigator.pushReplacementNamed(context, '/home');
                                  } else {
                                    showGlobalSnackBar(context, 'Invalid passcode');
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
