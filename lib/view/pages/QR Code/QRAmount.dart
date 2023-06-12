import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRAmount extends StatelessWidget {
  final String code;

   const QRAmount({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Add Amount'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            //QrImage(version:: QrVersions.auto),
            QrImageView(
              data: code,
              size: 150,
              version: 3,
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

            appButton(context, gradient(context), 'Proceed', '/progress')

          ],
        ),
      ),
    );
  }
}
