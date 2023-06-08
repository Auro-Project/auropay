import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../providers/theme_provider.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  _PasscodeScreenState createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  List<TextEditingController> passcodeControllers = [];
  int currentPasscodeIndex = 0;

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Create Passcode'),
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create a secure passcode you can use to log in \nto your app anytime.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SF Pro Display',
                    color: Colors.white38,
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
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(8),
                        ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  // Add your code here for the action when the button is pressed
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.deepPurpleAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  minimumSize: const Size(250, 60),
                ),
                child: const Text(
                  'USE FINGERPRINT/FACE ID',
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
          const SizedBox(height: 16),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: appButton(context, gradient(context), 'Proceed', '/confirmPasscode'),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
