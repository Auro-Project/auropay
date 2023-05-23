import 'package:auropay/view/pages/LoginScreens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'SignUpScreen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/AccountScreen1.png"),
          Positioned(
            top: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: Image.asset(
                "assets/images/Logo1.png",
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: RichText(
                    text: const TextSpan(
                      text: ' Start your financial \nactivity with ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white60,
                      ),
                      children: [
                        TextSpan(
                          text: 'AuroPay',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16.0),
                Container(
                  width: 250,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Log in",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),),
                  ),
                ),

                const SizedBox(height: 16.0),

                Container(
                  width: 250,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),),

                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
