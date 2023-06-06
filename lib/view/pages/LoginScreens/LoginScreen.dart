import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode = '91'; // Default country code

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro Display',
                        color: themeProvider.textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
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
                  color: Color(0xFF3A3A3B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
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
                      child: CountryCodePicker(
                        countryCode: countryCode,
                        onChanged: (String? newValue) {
                          setState(() {
                            countryCode = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF3A3A3B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      style:  TextStyle(color: themeProvider.textColor,),
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
              const SizedBox(height: 350),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 360,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      String phoneNumber = phoneNumberController.text;
                      // Process the user's input here
                      // For example, pass the data to the next screen
                     Navigator.pushNamed(context, '/code');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Send Code',
                      style: TextStyle(
                          color: themeProvider.textColor,
                          fontSize: 18.0,
                          fontFamily: 'SF Pro Display'
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CountryCodePicker extends StatelessWidget {
  final String countryCode;
  final ValueChanged<String?> onChanged;

  const CountryCodePicker({
    Key? key,
    required this.countryCode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: countryCode,
      onChanged: onChanged,
      items: <String>[
        '91',
        '44',
        '86',
        // Add more country codes as needed
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}