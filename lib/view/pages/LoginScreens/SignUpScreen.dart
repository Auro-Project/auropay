import 'package:auropay/view/widgets/CustomError.dart';
import '../../../view/widgets/CustomAppBar.dart';
import '../../../view/widgets/CustomField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import 'ConfirmOTP.dart';
import '../../../services/auth_service.dart'; // Import AuthService

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

  // Get an instance of AuthService
  final AuthService _authService = AuthService();

  void _sendOtp(BuildContext context) async {
    final String phoneNumber = '+91${_phoneNumberController.text.trim()}';
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.sendOtp(
          phoneNumber,
              (String verificationId) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmOTP(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                  countryCode: '91',
                  onVerificationComplete: (UserCredential credential) {},
                ),
              ),
            );
          },
        );
      } catch (e) {
        showGlobalSnackBar(context, 'Send OTP Error: $e');
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

  void _signUp(BuildContext context) async {
    final String fullName = _fullNameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String phoneNumber = _phoneNumberController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        await _authService.signUp(fullName, email, password, phoneNumber);
        showGlobalSnackBar(context, 'OTP Sent');
      } catch (e) {
        if (kDebugMode) {
          showGlobalSnackBar(context, 'Signup failed: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Sign Up'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        myField(context, 'Full Name', _fullNameController, false,
                            truePhrase: 'Please enter your full name', falsePhrase: null),
                        myField(context, 'Email', _emailController, false,
                            truePhrase: 'Please enter an email address', falsePhrase: null),
                        myField(context, 'Password', _passwordController, true,
                            truePhrase: 'Please enter a password', falsePhrase: null),
                        myField(context, 'Confirm Password', _confirmPasswordController, true,
                            truePhrase: 'Passwords do not match', falsePhrase: null),
                        myField(context, 'Phone Number', _phoneNumberController, false,
                            truePhrase: 'Please enter a phone number', falsePhrase: null),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: appButtonFunc(context, gradient(context), 'Sign Up', () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _sendOtp(context);
                    _signUp(context);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
