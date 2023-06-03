// ignore: file_names
import 'package:flutter/material.dart' show AppBar, BorderRadius, BoxDecoration, BuildContext, Color, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, FilterChip, FontWeight, Icon, IconButton, Icons, InputBorder, InputDecoration, ListTile, Padding, Row, Scaffold, SizedBox, State, StatefulWidget, StatelessWidget, Text, TextField, TextStyle, Widget, Wrap;

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color(0xFF262627),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.mic),
                          onPressed: () {
                            // TODO: Implement microphone button action
                          },
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'All',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: Text('Withdrawal'),
                  onSelected: (isSelected) {
                    // TODO: Implement chip selection action
                  },
                  selected: false,
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(color: Colors.black),
                ),
                FilterChip(
                  label: Text('Paid'),
                  onSelected: (isSelected) {
                    // TODO: Implement chip selection action
                  },
                  selected: false,
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(color: Colors.black),
                ),
                // Add more transaction types here
              ],
            ),
            SizedBox(height: 16.0),
            TransactionItem(
              logo: Icon(Icons.account_balance),
              payeeName: 'John Doe',
              accountNumber: '1234 5678 9012',
              amount: '\$500.00',
            ),
            TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            // Add more transaction items here
            TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final Widget logo;
  final String payeeName;
  final String accountNumber;
  final String amount;

  const TransactionItem({super.key,
    required this.logo,
    required this.payeeName,
    required this.accountNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: logo,
      title: Text(
        payeeName,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        accountNumber,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
