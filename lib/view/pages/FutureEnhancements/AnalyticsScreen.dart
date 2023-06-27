import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../Theme/theme_provider.dart';

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
        PaymentData(4, 4000),
        PaymentData(5, 2000),
        PaymentData(6, 8000),
        PaymentData(7, 9000),
        PaymentData(8, 2000),
        PaymentData(9, 6000),
      ],
    ),
  ];

   AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Payment Analytics", showLeadingIcon: false),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/shapes/gradHM.png",
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                 Text(
                  'Upcoming Screen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                   color: Theme.of(context).primaryColor,
                  ),
                ),
                 Text(
                  'Rs.5,000',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                   color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                 Text(
                  'Payment Overview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                   color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                    height: 300,
                    child: charts.LineChart(data),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentData {
  final int month;
  final int value;

  PaymentData(this.month, this.value);
}
