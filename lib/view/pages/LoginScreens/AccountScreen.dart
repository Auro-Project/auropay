import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/AccountScreen1.png"),
          Center(
            heightFactor: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric( vertical: 40.0),
                  decoration: border(context, borderRadius: 30.0),
                   child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 20.0),
                          child: Image.asset(
                            "assets/images/Logo.png",
                            height: 150,
                          ),
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          ' Start your financial \nactivity at Auro with\n Convenience',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    )
                ),
                const SizedBox(height: 80.0),
                appButton(context, gradient(context),'Sign In', '/login'),
                const SizedBox(height: 16.0),
                appButton(context, border(context), 'Sign Up', '/signup'),
                const SizedBox(height: 20.0),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 30,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Continue with',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,

                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                appButton(context, border(context), 'Sign In with Google', '/signup', iconPath: 'assets/images/icons/Google.svg'),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
