import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../responsive_widget.dart';
import '../../../Theme/appColors.dart';
import '../../../widgets/AppButtons.dart';
import '../../../widgets/Constants.dart';
import '../../../widgets/CustomError.dart';

class CreatePasscodeScreen extends StatelessWidget {
  const CreatePasscodeScreen({Key? key}) : super(key: key);

  get passcodeControllers => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Create Passcode'),
      backgroundColor: AppColors.primaryColor,
      body: ResponsiveWidget(
        largeScreen: _buildLargeScreen(context),
        mediumScreen: _buildMediumScreen(context),
        smallScreen: _buildSmallScreen(context),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildTextFieldList(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Flexible(
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
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: appButtonFunc(context, gradient(context), 'Proceed', () {
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

  Widget _buildMediumScreen(BuildContext context) {
    return _buildLargeScreen(context); // Use the large screen layout for medium screens
  }

  Widget _buildSmallScreen(BuildContext context) {
    return _buildLargeScreen(context); // Use the large screen layout for small screens
  }

  List<Widget> _buildTextFieldList(BuildContext context) {
    const textFieldSize = 60.0; // Adjust this value based on your design
    const textFieldMargin = 8.0; // Adjust this value based on your design
    const textFieldCount = 4;

    final List<TextEditingController> passcodeControllers = List.generate(
      textFieldCount,
          (_) => TextEditingController(),
    );

    void focusNextPasscodeField(int currentIndex) {
      if (currentIndex < textFieldCount - 1) {
        FocusScope.of(context).nextFocus();
      }
    }

    return List.generate(textFieldCount, (index) {
      return Container(
        width: textFieldSize,
        height: textFieldSize,
        margin: const EdgeInsets.symmetric(horizontal: textFieldMargin),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: passcodeControllers[index],
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
              focusNextPasscodeField(index);
            }
          },
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      );
    });
  }

  void savePasscode() async {
    final List<String> passcodes = passcodeControllers
        .map((controller) => controller.text)
        .where((text) => text.isNotEmpty)
        .toList();

    final String passcode = passcodes.join();
    const storage = FlutterSecureStorage();
    await storage.write(key: 'passcode', value: passcode);
  }
}

class ConfirmPasscodeScreen extends StatelessWidget {
  const ConfirmPasscodeScreen({Key? key}) : super(key: key);

  get passcodeControllers => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Confirm Passcode'),
      backgroundColor: AppColors.primaryColor,
      body: ResponsiveWidget(
        largeScreen: _buildLargeScreen(context),
        mediumScreen: _buildMediumScreen(context),
        smallScreen: _buildSmallScreen(context),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildTextFieldList(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: appButtonFunc(
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return _buildLargeScreen(context); // Use the large screen layout for medium screens
  }

  Widget _buildSmallScreen(BuildContext context) {
    return _buildLargeScreen(context); // Use the large screen layout for small screens
  }

  List<Widget> _buildTextFieldList(BuildContext context) {
    const textFieldSize = 60.0; // Adjust this value based on your design
    const textFieldMargin = 8.0; // Adjust this value based on your design
    const textFieldCount = 4;

    final List<TextEditingController> passcodeControllers = List.generate(
      textFieldCount,
          (_) => TextEditingController(),
    );

    void focusNextPasscodeField(int currentIndex) {
      if (currentIndex < textFieldCount - 1) {
        FocusScope.of(context).nextFocus();
      }
    }

    return List.generate(textFieldCount, (index) {
      return Container(
        width: textFieldSize,
        height: textFieldSize,
        margin: const EdgeInsets.symmetric(horizontal: textFieldMargin),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: passcodeControllers[index],
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
              focusNextPasscodeField(index);
            }
          },
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      );
    });
  }

  Future<bool> confirmPasscode() async {
    const storage = FlutterSecureStorage();
    final savedPasscode = await storage.read(key: 'passcode');

    final List<String> passcodes = passcodeControllers
        .map((controller) => controller.text)
        .where((text) => text.isNotEmpty)
        .toList();

    final String passcode = passcodes.join();

    return passcode == savedPasscode;
  }
}
