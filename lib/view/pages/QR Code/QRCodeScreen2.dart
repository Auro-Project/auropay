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
            Container(
              width: 370.0,
              height: 650.0,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/qrimage.png'),
                  fit: BoxFit.cover,
                ),
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 580),
                child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(Icons.qr_code_scanner_sharp, 'Scan'),
                  ],
                ),
              ),
            ),
            _buildInfoContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Container(
      width: 170.0,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
          colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)],
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
        icon: Icon(icon),
        label: Text(label),
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
