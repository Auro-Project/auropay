import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/CustomButton.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onBoardL.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.65,
                left: screenWidth * 0.25,
                right: screenWidth * 0.25,
                child: SvgPicture.asset(
                  "assets/images/icons/AP.svg",
                  // height: 55,
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.1,
                left: 0,
                right: 0,
                child: Center(
                  child: CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/account');
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
