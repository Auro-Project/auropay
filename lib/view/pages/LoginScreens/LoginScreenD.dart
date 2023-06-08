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

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black54,
  //     body: Center(
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               IconButton(
  //                 icon: const Icon(
  //                   Icons.arrow_back_ios_new,
  //                   color: Colors.white,
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               const Padding(
  //                 padding: EdgeInsets.all(70.0),
  //                 child: Text(
  //                   'Log in',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontFamily: 'SF-Pro-Display',
  //                     fontWeight: FontWeight.w600,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   'Phone number',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontFamily: 'SF-Pro-Display',
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.white38,
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Container(
  //                     width: 100,
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey,
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Center(child: Text(
  //                         countryCode,
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         fontFamily: 'SF-Pro-Display',
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.white,
  //                       ),
  //                     )),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Container(
  //                     width: 250,
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey,
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: TextField(
  //                       controller: phoneNumberController,
  //                       keyboardType: TextInputType.phone,
  //                       style: const TextStyle(color: Colors.black),
  //                       decoration: const InputDecoration(
  //                         border: InputBorder.none,
  //                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               const Text(
  //                 'Please confirm the country code and enter your phone number',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   fontFamily: 'SF-Pro-Display',
  //                   fontWeight: FontWeight.w500,
  //                   color: Colors.white38,
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //               Container(
  //                 width: 200,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   gradient: const LinearGradient(
  //                     colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)],
  //                     begin: Alignment.centerLeft,
  //                     end: Alignment.centerRight,
  //                   ),
  //                 ),
  //                 child: ElevatedButton(
  //                   onPressed: sendOTP,
  //                   style: ElevatedButton.styleFrom(
  //                     foregroundColor: Colors.transparent,
  //                     backgroundColor: Colors.transparent,
  //                     elevation: 0,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(30),
  //                     ),
  //                   ),
  //                   child: const Text(
  //                     'Send Code',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 17.0,
  //                       fontFamily: 'SF Pro Display',
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
          Center(
            child: const Text(
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
                child: Container(
                  decoration: gradient(context),
                  child: ElevatedButton(
                    onPressed: sendOTP,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Send Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                  ),
                ),
                // child: appButton(
                //     context, gradient(context), 'Send Code', '/confirmOTP'),
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
