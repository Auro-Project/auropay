import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {

  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'QR Code Scanner'),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Place the QR code in the area",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Scanning will start automatically",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
            ),
            Expanded(
              flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      allowDuplicates: true,
                      onDetect: (barcode, args) {
                        if(!isScanCompleted) {
                          String code = barcode.rawValue ?? '---';
                          isScanCompleted = true;
                          Navigator.pushNamed(context, '/qramount');
                        }
                      },),
                  ]
                ),
            ),
            const SizedBox(height: 20,),
            const Expanded(
                child: Text(
                  "Wait till the scan completes",
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
