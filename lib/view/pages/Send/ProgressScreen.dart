import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/success');
    });

    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      body: Stack(
        children: [
          Image.asset('assets/images/HomePage.png',),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Center(
                child: Text(
                  "Transaction in progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Please wait while we \nprocess your transaction",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
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
                    fontSize: 24,
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

