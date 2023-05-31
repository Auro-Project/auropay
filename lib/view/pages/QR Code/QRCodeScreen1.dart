import 'package:flutter/material.dart';

import 'QRCodeScreen2.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(70.0),
                  child: Text(
                    'QR Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 370.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 170.0,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QRScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.qr_code_scanner_sharp),
                      label: const Text('Scan'),
                    ),
                  ),
                  Container(
                    width: 170.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)],// Add your desired gradient colors here
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
                      icon: const Icon(Icons.payment),
                      label: const Text('Pay'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70.0),
            const Text(
              'Screen Your QR code',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/QRScan.png', // Add the path to the image asset
              width: 200,
              height: 200,
            ),
            const Text(
              'Click here to allow the app\n to access the camera',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w600,
                color: Colors.white38,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}