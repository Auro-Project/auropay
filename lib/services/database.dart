import '../model/UserData.dart';
import '../model/Transaction.dart';

class DatabaseService {
  // This will act as in-memory storage for users and transactions.
  final Map<String, UserData> _users = {};
  final List<myTransaction> _transactions = [];

}
