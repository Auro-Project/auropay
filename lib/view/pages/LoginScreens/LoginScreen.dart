import 'package:auropay/view/Theme/appColors.dart';

import '../../../view/pages/LoginScreens/passcode/PasscodeScreen.dart';
import '../../../view/widgets/AppButtons.dart';
import '../../../view/widgets/Constants.dart';
import '../../../view/widgets/CustomAppBar.dart';
import '../../../view/widgets/CustomError.dart';
import '../../../view/widgets/CustomField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User signed in successfully
      // You can perform any additional actions here
      // print('Logged in successfully. User ID: ${userCredential.user?.uid}');

      // Navigate to the next screen (CreatePasscode screen)
      Timer(const Duration(seconds: 0), () {
        showGlobalSnackBar(context, 'Logged in successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreatePasscodeScreen()),
        );
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // User with the specified email doesn't exist
          showGlobalSnackBar(context,'Please sign up first.');
        } else if (e.code == 'wrong-password') {
          // User with the specified email exists but entered the wrong password
          showGlobalSnackBar(context,'Incorrect password.');
        } else {
          // Other login errors
          showGlobalSnackBar(context,'Login failed. Error: ${e.message}');
        }
      } else {
        // Other errors
        showGlobalSnackBar(context,'Login failed. Error: $e');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: myAppBar(context, 'Sign In'),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            myField(context, 'Email', emailController, false),
            myField(context, 'Password', passwordController, true),
            const SizedBox(height: 16.0),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: appButtonFunc(context,margin: const EdgeInsets.only(bottom: 10.0),
                      gradient(context), 'Sign In', login)),
            )
          ],
        ),
      ),
    );
  }
}


