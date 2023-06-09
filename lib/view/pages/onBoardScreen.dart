import 'package:flutter/material.dart';
import '../widgets/CustomButton.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/GetStartedScreen.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
              top: 620,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Image.asset(
                  "assets/images/MiniLogo.png",
                  height: 55,
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                heightFactor: 2.5,
                child: CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/account');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
