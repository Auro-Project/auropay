import 'package:flutter/material.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/confirmpay');
    });

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
            _buildInfoContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer() {
    return Container(
      width: 200.0,
      height: 10.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 24,
            color: Colors.white,
          ),
          Text(
            'Point your camera at the QR code to make a payment',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
