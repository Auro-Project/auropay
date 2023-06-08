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
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Sign Up'),
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myField(context, 'Full Name', nameController, false),
              myField(context, 'Email Address', mailController, false),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: myPhone(context, 'Phone Number', phoneNumberController, '+91'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please confirm the country code and enter your phone\n number',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.w500,
                  color: Colors.white38,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: appButton(context, gradient(context), 'Sign Up', '/passcode'),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Column myField(BuildContext context, String label, TextEditingController controller, bool obscure) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w500,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 360,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white38,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(color: themeProvider.textColor),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
            ),
          ),
        ),
        const SizedBox(height: 20),

      ],
    );
  }

  Column myPhone(BuildContext context, String label, TextEditingController controller,String countryCode) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w500,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 50,
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
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
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

      ],
    );
  }
}
