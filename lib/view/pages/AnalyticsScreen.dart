import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatelessWidget {
  final List<charts.Series<PaymentData, int>> data = [
    charts.Series<PaymentData, int>(
      id: 'payments',
      colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
      domainFn: (PaymentData data, _) => data.month,
      measureFn: (PaymentData data, _) => data.value,
      data: [
        PaymentData(1, 500), // Replace with your data
        PaymentData(2, 1800),
        PaymentData(3, 5000),
        PaymentData(4, 5000),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                    'Payment Analytics',
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
            const SizedBox(height: 20),
            const Text(
              'Total Expenses',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Text(
              '\$10,000',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: charts.LineChart(data),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentData {
  final int month;
  final int value;

  PaymentData(this.month, this.value);
}
