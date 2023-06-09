import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:auropay/view/widgets/CustomField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import 'ConfirmOTPScreenD.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _sendOtp(BuildContext context) async {
    // final String phoneNumber = _phoneNumberController.text.trim();
    final String phoneNumber = '+91' + _phoneNumberController.text.trim();
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {
            // Auto-verification if the device automatically detects the SMS code
            FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print('Failed to send OTP: ${e.message}');
            // Handle the error if OTP sending fails
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmOTPScreen(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber, countryCode: '', onVerificationComplete: (PhoneAuthCredential ) {  },
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // Handle code auto-retrieval timeout
          },
        );
      } catch (e) {
        print('Send OTP Error: $e');
        // Handle the send OTP error
      }
    }
  }
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _signUp(BuildContext context) async {
    final String fullName = _fullNameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String phoneNumber = _phoneNumberController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final CollectionReference users = _firestore.collection('users');
        await users.doc(userCredential.user!.uid).set({
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmOTPScreen(phoneNumber: '', countryCode: '', verificationId: '', onVerificationComplete: (PhoneAuthCredential ) {  },)),
        );
      } catch (e) {
        if (kDebugMode) {
          print('Signup failed: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Sign Up'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
              children: [
                myField(context, 'Full Name', _fullNameController, false,
                    truePhrase: 'Please enter your full name', falsePhrase: null),
                myField(context, 'Email', _emailController, false,
                    truePhrase: 'Please enter an email address', falsePhrase: null),
                myField(context, 'Password', _passwordController, false,
                    truePhrase: 'Please enter a password', falsePhrase: null),
                myField(context, 'Confirm Password', _confirmPasswordController, false,
                    truePhrase: 'Passwords do not match', falsePhrase: null),
                myField(context, 'Phone Number', _phoneNumberController, false,
                    truePhrase: 'Please enter a phone number', falsePhrase: null),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: appButtonFunc(context, gradient(context), 'Sign Up',  () {
                      _sendOtp(context);
                      _signUp(context);
                    }),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}