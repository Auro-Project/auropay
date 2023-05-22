enum TransactionType { send, request }

class Transaction {
  String userImage;
  String userName;
  String dateTime;
  double amount;
  TransactionType transactionType;

  Transaction(
      {required this.userImage,
        required this.userName,
        required this.dateTime,
        required this.amount,
        required this.transactionType});
}