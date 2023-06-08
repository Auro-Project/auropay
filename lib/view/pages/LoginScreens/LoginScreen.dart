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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the left
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 16, right: 16),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 50,
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
                Expanded(
                  child: Container(
                    height: 50,
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
                          fontSize: 18,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: appButton(context, gradient(context), 'Send Code', '/code'),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
