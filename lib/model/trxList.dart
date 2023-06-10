
class ListItem {
  final String userImage;
  final String name;
  final String date;
  final String amount;

  ListItem( {required this.userImage ,required this.name, required this.date, required this.amount});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
      userImage: json['userImage'],
      name: json['name'],
      date: json['date'],
      amount: json['amount'],
    );
  }
}
