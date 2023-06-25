import 'package:auropay/view/Theme/appColors.dart';
import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
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
      appBar: myAppBar(context, 'Add Money'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: AppColors.grey
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40.0),
            Text(
              'Enter the amount you want to top-up',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
               color: Theme.of(context).cardColor,
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

              width: MediaQuery.of(context).size.width *0.3,
              height: 70,
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w500,
                   color: Theme.of(context).cardColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  // filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
            Text(
              'Amount (INR)',
              style: TextStyle(
                fontSize: 16.0,
                // fontWeight: FontWeight.w500,
               color: Theme.of(context).cardColor,
              ),
            ),
            SizedBox(height: 150.0),
            //write me 6 containers with 2 rows and 3 columns each having random amount of 100's
            //and a button to add the amount to the text field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                amountContainer('100'),
                amountContainer('200'),
                amountContainer('500'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                amountContainer('100'),
                amountContainer('200'),
                amountContainer('500'),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: appButtonFunc(context,
                      margin: EdgeInsets.only(bottom: 30.0) ,
                      gradient(context), 'Add Money', _performTopUp)),
            ),

          ],
        ),
      ),
    );
  }

  Container amountContainer(String text) {
    return Container(
      width: MediaQuery.of(context).size.width *0.3,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          _amountController.text = text;
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).hintColor, // Customize the text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
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
