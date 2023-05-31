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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: 400,
            height: 300,
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
              const Center(
                child: Text(
                  "Transaction in progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Please wait a few seconds the\ntransaction in process",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                    fontFamily: 'SF Pro Display',
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height:height*0.1,
              ),
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              //  cancel button
               SizedBox(
                height:height*0.2,
              ),
              const Center(
                child: Text(
                  "Processing...",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(
                height:height*0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

