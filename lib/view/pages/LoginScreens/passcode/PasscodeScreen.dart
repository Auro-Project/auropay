import '../../../../view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import '../../../../services/auth_service.dart';
import '../../../widgets/AppButtons.dart';
import '../../../widgets/Constants.dart';
import '../../../widgets/CustomError.dart';

class CreatePasscodeScreen extends StatefulWidget {
  const CreatePasscodeScreen({Key? key}) : super(key: key);

  @override
  _CreatePasscodeScreenState createState() => _CreatePasscodeScreenState();
}

class _CreatePasscodeScreenState extends State<CreatePasscodeScreen> {
  List<TextEditingController> passcodeControllers = [];
  List<FocusNode> passcodeFocusNodes = List.generate(4, (_) => FocusNode());
  PasscodeService passcodeService = PasscodeService();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      passcodeControllers.add(TextEditingController());
    }

    for (int i = 0; i < passcodeFocusNodes.length; i++) {
      passcodeFocusNodes[i].addListener(() {
        if (passcodeFocusNodes[i].hasFocus && passcodeControllers[i].text.isNotEmpty) {
          passcodeFocusNodes[i].unfocus();
          if (i < passcodeFocusNodes.length - 1) passcodeFocusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in passcodeControllers) {
      controller.dispose();
    }
    for (var focusNode in passcodeFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void focusNextPasscodeField(int currentIndex) {
    if (currentIndex < passcodeControllers.length - 1) {
      passcodeFocusNodes[currentIndex + 1].requestFocus();
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
                          focusNode: passcodeFocusNodes[i],
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
                              focusNextPasscodeField(i);
                            } else if (value.isEmpty && i > 0) {
                              passcodeFocusNodes[i - 1].requestFocus();
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
                child: appButtonFunc(
                    context,
                    gradient(context),
                    'Proceed',
                        () async {
                      await passcodeService.savePasscode(
                          passcodeControllers.map((controller) => controller.text).toList()
                      );
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
  PasscodeService passcodeService = PasscodeService();

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

  void navigateToHomeScreen() async {
    if (await passcodeService.confirmPasscode(
        passcodeControllers.map((controller) => controller.text).toList()
    )) {
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
                child: appButtonFunc(
                    context,
                    gradient(context),
                    'Confirm',
                    navigateToHomeScreen
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
