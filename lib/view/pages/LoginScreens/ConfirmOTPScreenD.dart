import 'package:auropay/view/pages/LoginScreens/passcode/CodeScreen.dart';
import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfirmOTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String verificationId;
  final Function(PhoneAuthCredential) onVerificationComplete;



  ConfirmOTPScreen({
    Key? key,
    required this.phoneNumber,
    required this.countryCode,
    required this.verificationId,
    required this.onVerificationComplete,
  }) : super(key: key);

  @override
  _ConfirmOTPScreenState createState() => _ConfirmOTPScreenState();
}

class _ConfirmOTPScreenState extends State<ConfirmOTPScreen> {
  List<String> enteredCode =
      List.filled(6, ''); // Initialize the list with empty strings
  String errorMessage = '';

  void signInWithCredential(PhoneAuthCredential credential) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signInWithCredential(credential);
      print('Sign In Success');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePasscodeScreen(),
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Enter the correct OTP'; // Display error message
      });
      print('Sign In Failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Enter OTP'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'Enter the OTP sent to',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.phoneNumber}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Container(
                    width: 40,
                    height: 60,
                    margin: const EdgeInsets.all( 5),
                    padding: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1, // Restrict the input to 1 digit
                      onChanged: (value) {
                        setState(() {
                          enteredCode[index] =
                              value; // Update the entered value at the corresponding index
                        });
                      },
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText:
                            'X', // Display a placeholder value or any other visual indicator
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                // Example navigation to the previous screen
                Navigator.pop(context);
              },
              child: const Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child:
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: appButtonFunc(context, gradient(context), 'Verify OTP', () {
                  // Join the enteredCode list into a single string
                  String code = enteredCode.join('');

                  // Create PhoneAuthCredential using the verificationId and the entered code
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: code,
                  );

                  // Call signInWithCredential method to sign in the user
                  signInWithCredential(credential);
                }),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
