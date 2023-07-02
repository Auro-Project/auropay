
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/AppButtons.dart';
import '../widgets/Constants.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset("assets/images/shapes/gradAC.png",
              width: MediaQuery.of(context).size.width,
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
                        Image.asset(
                          'assets/images/APlogo.png',
                          width: 110,
                        ),
                        const SizedBox(height: 30,),
                        SvgPicture.asset(
                          "assets/images/icons/APtext.svg",
                          width: 150,
                          //color: Theme.of(context).primaryColor.shade[300],
                          //   color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 10.0),
                         const Text(
                          textAlign: TextAlign.center,
                          ' Start your financial \nactivity at Auro with\n Convenience',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff1d2e56),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    )
                ),
                const SizedBox(height: 150.0),
                appButton(context, gradient(context),'Sign In', '/login'),
                const SizedBox(height: 20.0),
                appButton(context,
                    border(context,
                      colorbg: Colors.black.withOpacity(0.8),
                    ), 'Sign Up', '/signup'),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
