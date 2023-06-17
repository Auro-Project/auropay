import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRAmount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Add Amount'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                String code = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', // Custom scanner color
                  'Cancel', // Custom cancel button text
                  true, // Enable flash
                  ScanMode.QR, // Specify the scan mode (QR, BARCODE, or DEFAULT)
                );

                if (code != '-1') {
                  // Handle the scanned QR code
                  // Perform any necessary actions with the code
                }
              },
              child: Text('Scan QR Code'),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter amount to pay",
                labelStyle: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(
                fontFamily: "SF Pro Display",
                fontSize: 16,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Handle the text field value change
                // You can store the entered amount in a variable or perform any other actions
              },
            ),
            appButton(context, gradient(context), 'Proceed', '/progress'),
          ],
        ),
      ),
    );
  }
}
