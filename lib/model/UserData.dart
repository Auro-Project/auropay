import 'Transaction.dart';

class UserData {
  final String name;
  double balance; // Changed to double to represent monetary value
  final String expireDate;
  final List<myTransaction> transactions; // Changed to use the Transaction class

  UserData({
    required this.name,
    required this.balance,
    required this.expireDate,
    required this.transactions,
  });


  // Convert UserData to a Map. Useful for serialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'balance': balance,
      'expireDate': expireDate,
      'transactions': transactions.map((transaction) => transaction.toMap()).toList(),
    };
  }

  // Factory constructor to create UserData from a Map. Useful for deserialization
  factory UserData.fromMap(Map<String, dynamic> json) {
    List<dynamic> transactionsJson = json['transactions'] ?? [];
    List<myTransaction> transactions = transactionsJson.map((txJson) => myTransaction.fromMap(txJson)).toList();
    return UserData(
      name: json['name'],
      balance: json['balance'] is String ? double.tryParse(json['balance']) ?? 0.0 : json['balance'],
      expireDate: json['expireDate'],
      transactions: transactions,
    );
  }

  // Overriding toString to make it easier to print out UserData object
  @override
  String toString() {
    return 'UserData{name: $name, balance: $balance, expireDate: $expireDate, transactions: $transactions}';
  }
}
