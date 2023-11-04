import '../model/Transaction.dart';
import '../model/UserData.dart';
import 'database.dart';

class PaymentsService {
  final DatabaseService _databaseService;

  PaymentsService(this._databaseService);

  // Simulate a user top-up (credit)
  Future<bool> topUpBalance(String userId, int amount) async {
    try {
      UserData user = await _databaseService.getUserData(userId);
      user.credit(amount as double);

      myTransaction transaction = myTransaction(
        fromUserId: 'system', // assuming 'system' represents the source of credit
        toUserId: userId,
        amount: amount,
        type: TransactionType.credit,
      );

      await _databaseService.updateUserBalance(userId, user.balance);
      await _databaseService.recordTransaction(transaction);

      return true;
    } catch (e) {
      print('Error topping up balance: $e');
      return false;
    }
  }

  // Simulate sending money from one user to another (debit)
  Future<bool> sendMoney(String fromUserId, String toUserId, int amount) async {
    try {
      UserData sender = await _databaseService.getUserData(fromUserId);
      UserData receiver = await _databaseService.getUserData(toUserId);

      if (sender.balance < amount) {
        print('Insufficient funds');
        return false;
      }

      // Debit from sender and credit to receiver
      sender.debit(amount as double);
      receiver.credit(amount as double);

      myTransaction debitTransaction = myTransaction(
        fromUserId: fromUserId,
        toUserId: toUserId,
        amount: amount,
        type: TransactionType.debit,
      );

      myTransaction creditTransaction = myTransaction(
        fromUserId: fromUserId,
        toUserId: toUserId,
        amount: amount,
        type: TransactionType.credit,
      );

      // Update balances and record transactions atomically
      await _databaseService.updateUserBalance(fromUserId, sender.balance);
      await _databaseService.updateUserBalance(toUserId, receiver.balance);
      await _databaseService.recordTransaction(debitTransaction);
      await _databaseService.recordTransaction(creditTransaction);

      return true;
    } catch (e) {
      print('Error sending money: $e');
      return false;
    }
  }

  // Method to simulate topping up the user's balance
  // Future<void> topUpBalance(String userId, int amount) async {
  //   // Here you would interface with your backend or payment processor
  //   // For this example, we're just waiting for a bit to simulate a network call
  //   await Future.delayed(Duration(seconds: 2));
  //   // TODO: Implement actual logic to update the user's balance on the backend
  // }

  // Method to get the user's current balance
  // Replace with your method of retrieving the user's balance from the backend
  Future<int> getUserBalance(String userId) async {
    // TODO: Replace with actual logic to retrieve the user's balance
    return 100; // This is just a placeholder value
  }

// Further methods such as refund, withdraw, etc., would also be implemented here.
}
