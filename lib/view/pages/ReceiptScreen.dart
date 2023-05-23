import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/PaymentIcon.png",
                    width: 64,
                    height: 64,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Payment',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tuck Shop',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1000rs',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)], // Add your desired gradient colors here
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.file_download_sharp),
                    label: const Text('Receipt'),
                  ),
                ),
                Container(
                  width: 150.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)], // Add your desired gradient colors here
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality for the Pay button
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Share'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Information',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white38,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Tuck Shop',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Column(
                    children: [
                      Text(
                        'Date and time of the transaction',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white38,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '15.10.2022 20:01:54',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Column(
                    children: [
                      Text(
                        "Recipient's card - ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white38,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '**** **** **** 5539',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Column(
                    children: [
                      Text(
                        "Recipient's number - ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white38,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '738406225671',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
