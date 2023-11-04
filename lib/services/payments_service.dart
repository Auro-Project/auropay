import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Transaction.dart';
import 'database.dart';

class PaymentsService {
  final DatabaseService _databaseService;
  PaymentsService(this._databaseService);

  Future<String> performTopUp({required int topUpAmount, required String userId}) async {
    try {
      // Fetching the current user's balance from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return 'User document does not exist.';
      }

      int currentBalance = userDoc['balance'].toInt();

      // Updating the balance in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'balance': currentBalance + topUpAmount});

      // Creating a transaction
      myTransaction transaction = myTransaction(
        fromUserId: userId,
        toUserId: userId, // In this case, it's a top-up so from and to would be the same user
        amount: topUpAmount,
        type: TransactionType.credit,
        description: 'Added to Wallet', // since it's a top-up
      );

      // Recording the transaction
      await FirebaseFirestore.instance
          .collection('users') // Accessing the users collection
          .doc(userId) // Using the specific user's ID
          .collection('transactions') // Accessing the transactions subcollection
          .doc(transaction.id) // Creating a document with the transaction's ID
          .set(transaction.toMap()); // Setting the transaction data

      return 'Balance updated successfully!';
    } catch (e) {
      return 'Error updating balance: $e';
    }
  }

  Future<String> performDebit({required int debitAmount, required String userId, required String spentOn}) async {
    try {
      // Fetching the current user's balance from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return 'User document does not exist.';
      }

      int currentBalance = userDoc['balance'].toInt();
      if (debitAmount > currentBalance) {
        return 'Insufficient funds for debit.';
      }

      // Updating the balance in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'balance': currentBalance - debitAmount});

      // Creating a transaction
      myTransaction transaction = myTransaction(
        fromUserId: userId,
        toUserId: 'recipient_user_id', // Replace with the recipient's user ID
        amount: debitAmount,
        type: TransactionType.debit,
        description: 'Spent $spentOn', // since it's a debit
      );

      // Recording the transaction
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .doc(transaction.id)
          .set(transaction.toMap());

      return 'Balance debited successfully!';
    } catch (e) {
      return 'Error debiting balance: $e';
    }
  }
}
