import 'package:auropay/view/Theme/appColors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/AppButtons.dart';
import '../widgets/Constants.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: Stack(
        children: [
          Image.asset("assets/images/shapes/gradAC.png",
              fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric( vertical: 60.0),
                  decoration: border(context,
                      colorbg: Colors.white.withOpacity(0.1),
                      borderRadius: 30.0),
                   child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/icons/APxl.svg",
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          textAlign: TextAlign.center,
                          ' Start your financial \nactivity at Auro with\n Convenience',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    )
                ),
                const SizedBox(height: 150.0),
                appButton(context, gradient(context),'Sign In', '/login'),
                const SizedBox(height: 20.0),
                appButton(context, border(context), 'Sign Up', '/signup'),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
