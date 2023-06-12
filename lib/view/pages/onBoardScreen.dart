import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  image: AssetImage('assets/images/onBoardL.png'),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Positioned(
              top: 620,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: SvgPicture.asset(
                  "assets/images/icons/AP.svg",
                  // height: 55,
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                heightFactor: 3,
                child: Stack(
                  children: [
                    CustomButton(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/account');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
