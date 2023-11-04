import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../model/UserModel.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomError.dart';

class PaymentTopUpScreen extends StatefulWidget {
  @override
  _PaymentTopUpScreenState createState() => _PaymentTopUpScreenState();
}

class _PaymentTopUpScreenState extends State<PaymentTopUpScreen> {
  TextEditingController _amountController = TextEditingController();
  bool isLoading = false;
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    // _loadCurrentUserDetails();
  }

  // Future<void> _loadCurrentUserDetails() async {
  //   try {
  //     UserModel user = await UserModel.fetchCurrentUserDetails();
  //     if (user.uid != null) {
  //       setState(() {
  //         currentUser = user;
  //       });
  //     } else {
  //       // Handle the scenario where the uid is null.
  //       showGlobalSnackBar(context, 'Failed to load user details.');
  //     }
  //   } catch (e) {
  //     print('Error loading user details: $e');
  //     showGlobalSnackBar(context, 'Failed to load user details.');
  //   }
  // }

  Future<void> _performTopUp() async {
    setState(() {
      isLoading = true;
    });

    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      showGlobalSnackBar(context, 'You are not logged in.');
      return;
    }

    if (_amountController.text.trim().isEmpty) {
      setState(() {
        isLoading = false;
      });
      showGlobalSnackBar(context, 'Please enter an amount to top up.');
      return;
    }

    try {
      int topUpAmount = int.parse(_amountController.text.trim());

      // Fetching the current user's balance from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        setState(() {
          isLoading = false;
        });
        showGlobalSnackBar(context, 'User document does not exist.');
        return;
      }

      int currentBalance = userDoc['balance'];

      // Updating the balance in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'balance': currentBalance + topUpAmount});

      setState(() {
        isLoading = false;
      });

      showGlobalSnackBar(context, 'Balance updated successfully!');
      await Future.delayed(Duration(seconds: 1)); // Wait for 2 seconds
      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/')); // Return to HomeScreen after top-up

    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showGlobalSnackBar(context, 'Error updating balance: $e');
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
