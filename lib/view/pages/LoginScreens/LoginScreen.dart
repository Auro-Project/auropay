import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../providers/theme_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Log in'),
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
                Container(
                  width: 250,
                  height: 40,
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
                        fontSize: 14,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 400.0),
            Center(child: appButton(context, gradient(context),'Send Code', '/code')),
          ],
        ),
      ),
    );
  }
}
