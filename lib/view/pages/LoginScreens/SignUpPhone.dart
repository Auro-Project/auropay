import '../../../view/widgets/CustomError.dart';
import '../../../view/widgets/CustomAppBar.dart';
import '../../../view/widgets/CustomField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../../view/pages/LoginScreens/ConfirmOTP.dart';
import '../../../services/auth_service.dart'; // Import AuthService

class SignupPhoneScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const SignupPhoneScreen({
    Key? key,
    required this.fullName,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _SignupPhoneScreenState createState() => _SignupPhoneScreenState();
}

class _SignupPhoneScreenState extends State<SignupPhoneScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  void _sendOtp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String phoneNumber = '+91${_phoneNumberController.text.trim()}';
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
                  onVerificationComplete: (UserCredential credential) {
                    _authService.signUp(widget.fullName, widget.email, widget.password, phoneNumber);
                  },
                  fullName: widget.fullName,
                  email: widget.email,
                  password: widget.password,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Phone Verification'),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            myField(
                context,
                'Phone Number',
                _phoneNumberController,
                false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                }
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: appButtonFunc(
                      context,
                      gradient(context), 'Sign Up',
                          () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _sendOtp(context);
                        }
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
