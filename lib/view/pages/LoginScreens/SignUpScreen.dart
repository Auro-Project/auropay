import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../providers/theme_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode = '+91'; // Default country code

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Sign Up'),
      backgroundColor: themeProvider.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.w500,
                  color: Colors.white38,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: nameController,
                style: TextStyle(color: themeProvider.textColor),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.w500,
                  color: Colors.white38,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: nameController,
                style: TextStyle(color: themeProvider.textColor),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          countryCode,
                          style: TextStyle(
                            color: themeProvider.textColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: themeProvider.textColor),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please confirm the country code and enter your phone number',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.w500,
                    color: Colors.white38,
                  ),
                ),
                const SizedBox(height: 300),
                Center(child: appButton(context, gradient(context), 'Sign Up', '/passcode')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
