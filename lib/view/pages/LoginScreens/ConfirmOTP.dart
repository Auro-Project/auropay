import 'package:auropay/services/auth_service.dart';
import 'package:auropay/view/pages/LoginScreens/LoginScreen.dart';
import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:auropay/view/widgets/CustomError.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmOTP extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String verificationId;
  final Function(UserCredential) onVerificationComplete;
  final String fullName;
  final String email;
  final String password;

  const ConfirmOTP({
    Key? key,
    required this.phoneNumber,
    required this.countryCode,
    required this.verificationId,
    required this.onVerificationComplete,
    required this.fullName,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _ConfirmOTPState createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  List<String> enteredCode = List.filled(6, '');
  String errorMessage = '';
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Enter OTP'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              'Enter the OTP sent to',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.phoneNumber,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) {
                        setState(() {
                          enteredCode[index] = value;
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
                        hintText: 'X',
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
                Navigator.pop(context);
              },
              child: Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: appButtonFunc(context, gradient(context), 'Verify OTP',
                          () async {
                        String code = enteredCode.join('');
                        try {
                          UserCredential userCredential = await _authService
                              .verifyOTP(widget.verificationId, code);
                          if (FirebaseAuth.instance.currentUser != null) {
                            // await _authService.signUp(widget.fullName, widget.email, widget.password, widget.phoneNumber);
                            widget.onVerificationComplete(userCredential);
                            showGlobalSnackBar(context, 'Signed Up successfully');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          } else {
                            setState(() {
                              errorMessage = 'Invalid OTP';
                              showGlobalSnackBar(context, errorMessage);
                            });
                          }
                        } catch (e) {
                          print('OTP Verification Error: $e');
                          setState(() {
                            errorMessage = 'An error occurred during verification';
                            showGlobalSnackBar(context, errorMessage);
                          });
                        }
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
