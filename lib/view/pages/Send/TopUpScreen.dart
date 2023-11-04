import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../model/UserModel.dart';
import '../../../services/database.dart';
import '../../../services/payments_service.dart';
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
  double _containerWidth = 100; // Initial width, adjust as needed
  bool isLoading = false;
  UserModel? currentUser;
  final DatabaseService _databaseService = DatabaseService();


  @override
  void initState() {
    super.initState();
    _amountController.addListener(_updateContainerWidth);
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateContainerWidth);
    _amountController.dispose();
    super.dispose();
  }

  void _updateContainerWidth() {
    final textLength = _amountController.text.length;
    double calculatedWidth = textLength * 40.0; // Example character width, adjust as needed
    final maxWidth = MediaQuery.of(context).size.height * 0.7;

    setState(() {
      _containerWidth = calculatedWidth.clamp(100.0, maxWidth);
    });
  }

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

    int topUpAmount = int.parse(_amountController.text.trim());
    String result = await PaymentsService(_databaseService).performTopUp(topUpAmount: topUpAmount, userId: userId);

    setState(() {
      isLoading = false;
    });

    showGlobalSnackBar(context, result);
    if (result == 'Balance updated successfully!') {
      await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/')); // Return to HomeScreen after top-up
    }
  }

  // Future<void> _performTopUp() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
  //   if (userId == null) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showGlobalSnackBar(context, 'You are not logged in.');
  //     return;
  //   }
  //
  //   if (_amountController.text.trim().isEmpty) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showGlobalSnackBar(context, 'Please enter an amount to top up.');
  //     return;
  //   }
  //
  //   try {
  //     int topUpAmount = int.parse(_amountController.text.trim());
  //
  //     // Fetching the current user's balance from Firestore
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();
  //
  //     if (!userDoc.exists) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       showGlobalSnackBar(context, 'User document does not exist.');
  //       return;
  //     }
  //
  //     int currentBalance = userDoc['balance'].toInt();
  //
  //     // Updating the balance in Firestore
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .update({'balance': currentBalance + topUpAmount});
  //
  //     // Creating a transaction
  //     myTransaction transaction = myTransaction(
  //       fromUserId: userId,
  //       toUserId: userId, // In this case, it's a top-up so from and to would be the same user
  //       amount: topUpAmount,
  //       type: TransactionType.credit,
  //       description: 'Added to Wallet', // since it's a top-up
  //     );
  //
  //     // Recording the transaction
  //     await FirebaseFirestore.instance
  //         .collection('users') // Accessing the users collection
  //         .doc(userId) // Using the specific user's ID
  //         .collection('transactions') // Accessing the transactions subcollection
  //         .doc(transaction.id) // Creating a document with the transaction's ID
  //         .set(transaction.toMap()); // Setting the transaction data
  //
  //     setState(() {
  //       isLoading = false;
  //     });
  //
  //     showGlobalSnackBar(context, 'Balance updated successfully!');
  //     await Future.delayed(Duration(seconds: 1)); // Wait for 1 second
  //     Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/')); // Return to HomeScreen after top-up
  //
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showGlobalSnackBar(context, 'Error updating balance: $e');
  //   }
  // }
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Add Money"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            Text(
              'Enter Amount',
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: height * 0.8,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  height: height * 0.115,
                  width: _containerWidth,  // Adapting width with a maximum constraint
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w500,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            appButtonFunc(context, gradient(context), 'Add Money', _performTopUp),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }

}
