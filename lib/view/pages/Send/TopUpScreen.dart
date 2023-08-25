import 'package:auropay/view/widgets/CustomError.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/UserModel.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';

class PaymentTopUpScreen extends StatefulWidget {
  @override
  _PaymentTopUpScreenState createState() => _PaymentTopUpScreenState();
}

class _PaymentTopUpScreenState extends State<PaymentTopUpScreen> {
  TextEditingController _amountController = TextEditingController();
  UserModel? currentUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserDetails();
  }

  Future<void> _loadCurrentUserDetails() async {
    try {
      UserModel user = await UserModel.fetchCurrentUserDetails();
      setState(() {
        currentUser = user;
      });
    } catch (e) {
      print('Error loading user details: $e');
    }
  }

  void _performTopUp() async {
    if (currentUser != null) {
      try {
        int topUpAmount = int.parse(_amountController.text);
        int newBalance = (currentUser!.balance ?? 0) + topUpAmount;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .update({'balance': newBalance});

        setState(() {
          currentUser!.balance = newBalance;
          isLoading = false;
        });

        Navigator.pop(context); // Return to HomeScreen after top-up
      } catch (e) {
        showGlobalSnackBar(context, 'Error updating balance: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Add Money"),
      body: Center(
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
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                height: 150,
                width: width*0.4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 50.0, // Increased font size for the input
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0, // Adjusted padding for the increased font size
                        horizontal: 20.0,
                      ),
                      border: InputBorder.none, // Removes underline from TextField
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            appButtonFunc(context, gradient(context), 'Add Money', _performTopUp),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}

