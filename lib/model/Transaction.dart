import 'package:uuid/uuid.dart';

enum TransactionType { credit, debit }

class myTransaction {
  final String id;
  final String fromUserId;
  final String toUserId;
  final double amount;
  final DateTime timestamp;
  final TransactionType type;

  myTransaction({
    String? id,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    DateTime? timestamp,
    required this.type,
  })  : this.id = id ?? const Uuid().v4(), // Generate a new unique ID if none provided
        this.timestamp = timestamp ?? DateTime.now(); // Use the current time if none provided

  // Convert a Transaction into a Map. The keys must correspond to the names of the
  // columns in the database if you're planning to use this model with a database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString(),
    };
  }

  // Implement a method to create a Transaction from a Map
  factory myTransaction.fromMap(Map<String, dynamic> map) {
    return myTransaction(
      id: map['id'],
      fromUserId: map['fromUserId'],
      toUserId: map['toUserId'],
      amount: map['amount'],
      timestamp: DateTime.parse(map['timestamp']),
      type: TransactionType.values.firstWhere(
            (e) => e.toString() == map['type'],
        orElse: () => TransactionType.debit, // default value if not found
      ),
    );
  }

  // Implement toString to make it easier to see information about
  // each transaction when using the print statement.
  @override
  String toString() {
    return 'Transaction{id: $id, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, timestamp: $timestamp, type: $type}';
  }
}

// class myTransaction {
//   final String id;
//   final String userId;
//   final int amount;
//   final String type; // Could be 'credit' or 'debit'
//   final DateTime timestamp;
//   final String description;
//
//   myTransaction({
//     required this.id,
//     required this.userId,
//     required this.amount,
//     required this.type,
//     required this.timestamp,
//     required this.description,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'userId': userId,
//     'amount': amount,
//     'type': type,
//     'timestamp': timestamp.toIso8601String(),
//     'description': description,
//   };
//
//   factory myTransaction.fromJson(Map<String, dynamic> json, String id) => myTransaction(
//     id: id,
//     userId: json['userId'] as String,
//     amount: json['amount'] as int,
//     type: json['type'] as String,
//     timestamp: DateTime.parse(json['timestamp'] as String),
//     description: json['description'] as String,
//   );
//
//
// }



class ListItem {
  final String userImage;
  final String name;
  final String date;
  final String amount;
  final String type;  // Add this line

  ListItem({required this.userImage, required this.name, required this.date, required this.amount, required this.type});  // Modify this line

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
      userImage: json['userImage'],
      name: json['name'],
      date: json['date'],
      amount: json['amount'],
      type: json['type'],  // Add this line
    );
  }
}
