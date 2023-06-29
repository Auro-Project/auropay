
import 'Transaction.dart';

class UserData {
  final String name;
  final String balance;
  final String expireDate;
  late final List<ListItem> transactions;

  UserData({
    required this.name,
    required this.balance,
    required this.expireDate,
    required this.transactions,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    List<dynamic> transactionsJson = json['transactions'];
    List<ListItem> transactions = transactionsJson.map((json) => ListItem.fromJson(json)).toList();
    return UserData(
      name: json['name'],
      balance: json['balance'],
      expireDate: json['expireDate'],
      transactions: transactions,
    );
  }

}
