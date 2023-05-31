import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class ReceiptScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReceiptScreen({Key? key}) : super(key: key);

  Future<void> _downloadReceipt() async {
    final receiptText = _generateReceiptText();
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/receipt.txt');
    await file.writeAsString(receiptText);
    _showSnackBar('Receipt downloaded successfully');
  }

  Future<void> _shareReceipt() async {
    final receiptText = _generateReceiptText();
    final tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/receipt.txt');
    await file.writeAsString(receiptText);

    await Share.shareFiles([file.path]);
  }

  String _generateReceiptText() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd.MM.yyyy HH:mm:ss').format(now);

    final StringBuffer buffer = StringBuffer();
    buffer.writeln('Payment Receipt');
    buffer.writeln('Name: Tuck Shop');
    buffer.writeln('Date and Time of Transaction: $formattedDate');
    buffer.writeln("Recipient's Card: **** **** **** 5539");
    buffer.writeln("Recipient's Number: 738406225671");

    return buffer.toString();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/PaymentIcon.png",
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Payment',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tuck Shop',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '100rs',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'SF Pro Display',
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
                      colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _downloadReceipt();
                    },
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
                      colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _shareReceipt();
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
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white38,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          'Tuck Shop',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Divider(
                      color: Colors.white38,
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date and Time of Transaction',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white38,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '15.10.2022 20:01:54',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Divider(
                      color: Colors.white38,
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recipient's Card",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white38,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '**** **** **** 5539',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Divider(
                      color: Colors.white38,
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recipient's Number",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white38,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '738406225671',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
