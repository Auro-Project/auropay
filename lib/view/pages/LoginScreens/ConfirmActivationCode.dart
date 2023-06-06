import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ConfirmActivationCode extends StatelessWidget {
  const ConfirmActivationCode({Key? key, required String phoneNumber, required String countryCode}) : super(key: key);

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
                      'Enter Activation Code',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
                  (index) => Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 1) {
                      if (index < 5) {
                        // Move the focus to the next TextFormField
                        FocusScope.of(context).nextFocus();
                      } else {
                        // Perform any action you want after the last digit is entered
                        // For example, you can trigger a verification process or submit the code
                      }
                    }
                  },
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
           Column(
            children: [
              const Text(
                'A code has been sent to your phone',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.w600,
                  color: Colors.white38,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add your code here for the action when the button is pressed
                },
                child: const Text(
                  'Request code again',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurpleAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 350),
          Container(
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
               Navigator.pushNamed(context, '/passcode');
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
                'Continue',
                style: TextStyle(
                  color: themeProvider.textColor,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
