import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../providers/theme_provider.dart';

class ConfirmActivationCode extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;

  const ConfirmActivationCode({
    Key? key,
    required this.phoneNumber,
    required this.countryCode,
  }) : super(key: key);

  @override
  _ConfirmActivationCodeState createState() => _ConfirmActivationCodeState();
}

class _ConfirmActivationCodeState extends State<ConfirmActivationCode> {

  @override
  void dispose() {
    for (int i = 0; i < 6; i++) {
      textControllers[i].dispose();
      focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Enter Activation Code'),
      backgroundColor: themeProvider.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                otpCode(context, 0),
                otpCode(context, 1),
                otpCode(context, 2),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                otpCode(context, 3),
                otpCode(context, 4),
                otpCode(context, 5),
              ],
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 300),
            Center(child: appButton(context, gradient(context),'Continue', '/passcode')),
          ],
        ),
      ),
    );
  }
}


List<TextEditingController> textControllers =
List.generate(6, (_) => TextEditingController());
List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

Container otpCode(BuildContext context, int index) {
  return Container(
    width: 60,
    height: 60,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      color: Colors.white38,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: TextFormField(
        controller: textControllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: '', // Remove the character counter
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            textControllers[index].text = value.substring(0, 1); // Keep only the first character
            focusNodes[index].unfocus(); // Remove focus from the current field
            if (index < 5) {
              focusNodes[index + 1].requestFocus(); // Move focus to the next input field
            }
          }
        },
      ),
    ),
  );
}
