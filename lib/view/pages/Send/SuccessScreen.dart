import 'package:flutter/material.dart';

import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            width: 450,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD6E1FF),
                  Color(0xFFC3E6FF),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  appButton(context, gradient(context),'Transaction Complete', '/progress'),
                  SizedBox(height: height * 0.05),
                  _buildText(context, "- ₹ 5000", 24, FontWeight.bold),
                  SizedBox(height: height * 0.05),
                  _buildRow(context, "From", "Zahar Palaznik", Icons.account_circle_sharp),
                  SizedBox(height: height * 0.02),
                  _buildRow(context, "To", "Irin Machahen", Icons.account_circle_sharp),
                  SizedBox(height: height * 0.02),
                  _buildRow(context, "Date", "12 April,2023", Icons.calendar_today_sharp),
                  SizedBox(height: height * 0.02),
                  _buildRow(context, "Remaining", "₹ 2896", Icons.attach_money_sharp),
                  SizedBox(height: height * 0.1),
                  appButton(context, border(context, colorbg: Colors.black.withOpacity(0.8)), 'Done', '/home'),
                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, String text, double size, FontWeight weight) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'SF Pro Display',
          fontWeight: weight,
          fontSize: size,
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String leading, String trailing, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9CA2E8),
                      Color(0xFF7CABEC),
                    ],
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            _buildText(context, leading, 18, FontWeight.w500),
          ],
        ),
        _buildText(context, trailing, 18, FontWeight.w500),
      ],
    );
  }
}