import '../model/UserData.dart';
import '../model/Transaction.dart';

class DatabaseService {
  // This will act as in-memory storage for users and transactions.
  // In a real application, you would use an actual database.
  final Map<String, UserData> _users = {};
  final List<myTransaction> _transactions = [];

  Future<UserData> getUserData(String userId) async {
    // In a real application, you'd fetch this from the database.
    // For now, we're assuming the user always exists for simplicity.
    return _users[userId]!;
  }

  Future<void> updateUserBalance(String userId, double newBalance) async {
    // In a real application, you'd update the user's balance in the database.
    if (_users.containsKey(userId)) {
      UserData user = _users[userId]!;
      user.balance = newBalance; // Update the in-memory user's balance
      // Replace the following line with a real database update operation
      _users[userId] = user; // Mock database update
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> recordTransaction(myTransaction transaction) async {
    // In a real application, you'd record the transaction in the database.
    // Here, we just add it to our in-memory list of transactions.
    _transactions.add(transaction);
    // In a real scenario, you would include logic to ensure the transaction
    // is recorded atomically along with any balance updates.
  }

  // Initialization method to add a user to the mock database, for testing.
  void addUser(UserData user) {
    _users[user.name] = user;
  }

  // You might also want to include methods to handle the transactions list,
  // like getting all transactions for a user, etc.
  List<myTransaction> getUserTransactions(String userId) {
    return _transactions.where((t) => t.fromUserId == userId || t.toUserId == userId).toList();
  }


}
