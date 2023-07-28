import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/success');
    });

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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildText(context, "Transaction in progress", 24, FontWeight.w600),
              const SizedBox(height: 20),
              _buildCenteredText(context, "Please wait a few seconds the\ntransaction in process", 20),
              SizedBox(height: height * 0.1),
              Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
              SizedBox(height: height * 0.2),
              _buildText(context, "Processing...", 22, FontWeight.normal),
              SizedBox(height: height * 0.05),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, String text, double size, FontWeight weight) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'SF Pro Display',
          fontWeight: weight,
          fontSize: size,
        ),
      ),
    );
  }

  Widget _buildCenteredText(BuildContext context, String text, double size) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'SF Pro Display',
          fontSize: size,
        ),
      ),
    );
  }
}