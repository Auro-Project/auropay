import 'package:uuid/uuid.dart';

enum TransactionType { credit, debit }

class myTransaction {
  final String id;
  final String fromUserId;
  final String toUserId;
  final int amount;
  final String description; // Add a description field
  final DateTime timestamp;
  final TransactionType type;

  myTransaction({
    String? id,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    required this.description, // Require the description as a named parameter
    DateTime? timestamp,
    required this.type,
  })  : this.id = id ?? const Uuid().v4(), // Generate a new unique ID if none provided
        this.timestamp = timestamp ?? DateTime.now(); // Use the current time if none provided

  // Modify toMap to include the description
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'amount': amount,
      'description': description, // Include the description field
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString(),
    };
  }

  // Modify fromMap to handle the description
  factory myTransaction.fromMap(Map<String, dynamic> map) {
    return myTransaction(
      id: map['id'],
      fromUserId: map['fromUserId'],
      toUserId: map['toUserId'],
      amount: map['amount'],
      description: map['description'] ?? '', // Provide a default value if the description is missing
      timestamp: DateTime.parse(map['timestamp']),
      type: TransactionType.values.firstWhere(
            (e) => e.toString() == map['type'],
        orElse: () => TransactionType.debit, // default value if not found
      ),
    );
  }

  @override
  String toString() {
    // Include the description in the toString
    return 'Transaction{id: $id, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, description: $description, timestamp: $timestamp, type: $type}';
  }
}
