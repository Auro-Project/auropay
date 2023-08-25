import 'package:flutter/material.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomField.dart';
import '../../../view/pages/LoginScreens/SignUpPhone.dart'; // Import AuthService
// import 'package:http/http.dart' as http;

class SignupInfoScreen extends StatefulWidget {
  const SignupInfoScreen({super.key});

  @override
  _SignupInfoScreenState createState() => _SignupInfoScreenState();
}

class _SignupInfoScreenState extends State<SignupInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordValid(String password) {
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return password.length >= 8 &&
        hasDigits &&
        hasUppercase &&
        hasLowercase &&
        hasSpecialCharacters;
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address';
    }

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@aurouniversity.edu.in$").hasMatch(email)) {
      return 'Enter a valid email from @aurouniversity.edu.in';
    }

    return null;
  }

  // Future<bool> doesEmailExist(String email) async {
  //   // For now, we are just mocking a delay. In reality, you'd make an API call here.
  //   await Future.delayed(Duration(seconds: 2));
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Sign Up'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      myField(
                          context,
                          'Full Name',
                          _fullNameController,
                          false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          }
                      ),
                      myField(
                          context,
                          'Email',
                          _emailController,
                          false,
                          validator: _validateEmail
                      ),
                      myField(
                          context,
                          'Password',
                          _passwordController,
                          true,
                          subLabel: '\n Password must be at least 8 chars long, with special char, \n upper & lower case, and digits',
                          validator: (value) {
                            if (value == null || !_isPasswordValid(value)) {
                              return 'Password must be at least 8 chars long, with special char, upper & lower case, and digits';
                            }
                            return null;
                          }
                      ),
                      myField(
                          context,
                          'Confirm Password',
                          _confirmPasswordController,
                          true,
                          validator: (value) {
                            if (value == null || value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }
                      ),
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
              child: appButtonFunc(
                  context,
                  gradient(context),
                  'Sign Up',
                      () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPhoneScreen(
                            fullName: _fullNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        ),
                      );
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
