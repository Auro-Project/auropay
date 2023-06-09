import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:auropay/view/widgets/CustomField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

      print('Logged in successfully. User ID: ${userCredential.user?.uid}');
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // User with the specified email doesn't exist
          print('Please sign up first.');
        } else if (e.code == 'wrong-password') {
          // User with the specified email exists but entered the wrong password
          print('Incorrect password.');
        } else {
          // Other login errors
          print('Login failed. Error: ${e.message}');
        }
      } else {
        // Other errors
        print('Login failed. Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Sign In'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            myField(context, 'Email', emailController, false),
            myField(context, 'Password', passwordController, true),
            SizedBox(height: 16.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: appButtonFunc(context,margin: EdgeInsets.only(bottom: 10.0),
                      gradient(context), 'Sign In', login)),
            )
          ],
        ),
      ),
    );
  }
}
