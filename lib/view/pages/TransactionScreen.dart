import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/HomePage.png"),
          const Center(
            child: Text(
              "Transaction",
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
