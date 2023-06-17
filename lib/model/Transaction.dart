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
