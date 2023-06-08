import 'package:auropay/view/pages/LoginScreens/ConfirmOTPScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../providers/theme_provider.dart';
import 'ConfirmOTPScreenD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode = '+91'; // Default country code

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
/*
  void sendOTP() async {
    String phoneNumber = phoneNumberController.text.trim();
    String fullPhoneNumber = '$countryCode$phoneNumber';

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieval of verification code completed
        // This callback is optional
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification failed
        if (kDebugMode) {
          print('Verification Failed: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // Navigate to the ConfirmActivationCode screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmOTPScreen(
              phoneNumber: phoneNumber,
              countryCode: countryCode,
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Code auto-retrieval timed out
      },
      timeout: const Duration(seconds: 60),
    );
  }
*/
  void sendOTP() async {
    String phoneNumber = phoneNumberController.text.trim();
    String fullPhoneNumber = '$countryCode$phoneNumber';

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: fullPhoneNumber)
        .get();

    if (snapshot.size == 1) {
      // User exists, send OTP
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto-retrieval of verification code completed
          // This callback is optional
        },
        verificationFailed: (FirebaseAuthException e) {
          // Verification failed
          if (kDebugMode) {
            print('Verification Failed: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to the ConfirmOTPScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmOTPScreen(
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Code auto-retrieval timed out
        },
        timeout: const Duration(seconds: 60),
      );
    } else {
      // User does not exist, show error message or navigate to sign up screen
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User not found'),
            content: const Text('Please sign up to continue.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Sign in'),
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns children to the left
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Text(
              'Phone number',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w500,
                color: Colors.white38,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      countryCode,
                      style: TextStyle(
                        color: themeProvider.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: themeProvider.textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Enter your phone number', // Placeholder text
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 18,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Please confirm the country code and enter your phone\n number',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w500,
                color: Colors.white38,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: appButtonFunc(context, gradient(context), 'Send Code',sendOTP),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OTPScreen extends StatefulWidget {
  final String verificationId;

  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // OTP verification successful
      // Add your desired code here, e.g., navigate to the home screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      if (kDebugMode) {
        print('OTP Verified');
      }
    } catch (e) {
      // OTP verification failed
      if (kDebugMode) {
        print('OTP Verification Failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the OTP sent to your phone',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16.0),
                decoration: const InputDecoration(
                  labelText: 'OTP',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOTP,
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
