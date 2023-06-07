import 'package:flutter/material.dart';

class PaymentTopUpScreen extends StatefulWidget {
  @override
  _PaymentTopUpScreenState createState() => _PaymentTopUpScreenState();
}

class _PaymentTopUpScreenState extends State<PaymentTopUpScreen> {
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _performTopUp() {
    // Implement your payment top-up logic here
    // You can use the value from _amountController.text to get the top-up amount
    // For demonstration purposes, let's print the top-up amount to the console
    print('Performing top-up with amount: ${_amountController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Top-Up'),
        backgroundColor: Colors.blue, // Customize the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/payment.png', // Add an image to represent payment
              height: 150,
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money), // Add a money icon
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _performTopUp,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: Text(
                  'Top-Up',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Customize the button color
                onPrimary: Colors.white, // Customize the text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentTopUpScreen(),
  ));
}
