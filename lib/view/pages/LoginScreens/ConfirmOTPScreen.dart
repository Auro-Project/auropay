import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../providers/theme_provider.dart';

class ConfirmOTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;

  const ConfirmOTPScreen({
    Key? key,
    required this.phoneNumber,
    required this.countryCode,
  }) : super(key: key);

  @override
  _ConfirmOTPScreenState createState() => _ConfirmOTPScreenState();
}

class _ConfirmOTPScreenState extends State<ConfirmOTPScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Enter Activation Code'),
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              otpInput(context, 0),
              otpInput(context, 1),
              otpInput(context, 2),
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              otpInput(context, 3),
              otpInput(context, 4),
              otpInput(context, 5),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              const Text(
                'A code has been sent to your phone',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.w600,
                  color: Colors.white38,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add your code here for the action when the button is pressed
                },
                child: const Text(
                  'Request code again',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurpleAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: appButton(context, gradient(context), 'Confirm OTP', '/createPasscode'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container otpInput(BuildContext context, int index,) {

    List<TextEditingController> textControllers =
    List.generate(6, (_) => TextEditingController());
    List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

    return Container(
      width: 60, // Adjust the width of the container
      height: 65,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: textControllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty) {
            focusNodes[index + 1].requestFocus();
          }
        },
        style: const TextStyle(
          fontSize: 18, // Adjust the font size
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
