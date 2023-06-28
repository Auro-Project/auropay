import 'package:auropay/view/widgets/CustomError.dart';

import 'package:flutter/material.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomField.dart';
import 'SignUpPhone.dart'; // Import AuthService

class SignupInfoScreen extends StatefulWidget {
  @override
  _SignupInfoScreenState createState() => _SignupInfoScreenState();
}

class _SignupInfoScreenState extends State<SignupInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                      myField(context, 'Full Name', _fullNameController, false,
                          truePhrase: 'Please enter your full name', falsePhrase: null),
                      myField(context, 'Email', _emailController, false,
                          truePhrase: 'Please enter an email address', falsePhrase: null),
                      myField(context, 'Password', _passwordController, true,
                          truePhrase: 'Please enter a password', falsePhrase: null),
                      myField(context, 'Confirm Password', _confirmPasswordController, true,
                          truePhrase: 'Passwords do not match', falsePhrase: null),
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
                  gradient(context), 'Sign Up',
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
