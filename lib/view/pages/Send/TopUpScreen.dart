import 'package:flutter/material.dart';

import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import 'ProgressScreen.dart';

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
    print('Performing top-up with amount: ${_amountController.text}');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Add Money"),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.grey[300],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40.0),
              Text(
                'Enter amount',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              //const SizedBox(height: 30.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                width: MediaQuery.of(context).size.width * 0.3,
                height: 70,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    //color: Theme.of(context).primaryColor, // This is the desired color
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 40.0,
                        horizontal: 20.0,
                      ),
                      border: InputBorder.none, // Removes underline from TextField
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 80.0),
              Container(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  children: [
                    '1', '2', '3',
                    '4', '5', '6',
                    '7', '8', '9',
                    '.', '0'
                  ].map((text) => numberButton(context, text)).toList(),
                ),
              ),
              const SizedBox(height: 150.0),
              appButton(context, gradient(context),'Add', '/progress'),
            ],
          ),
        ),
      ),
    );
  }

  Widget numberButton(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          //backgroundColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        onPressed: () {
          _amountController.text = _amountController.text + text;
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w500,
            // color: Theme.of(context).scaffoldBackgroundColor,
            color: Theme.of(context).primaryColor,
          ),
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