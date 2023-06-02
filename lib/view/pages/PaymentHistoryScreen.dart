import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF262627),
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
                          icon: const Icon(Icons.mic),
                          onPressed: () {
                            // TODO: Implement microphone button action
                          },
                        ),
                        const Expanded(
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
                const SizedBox(width: 16.0),
                Container(
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'All',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: const Text('Withdrawal'),
                  onSelected: (isSelected) {
                    // TODO: Implement chip selection action
                  },
                  selected: false,
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blue,
                  labelStyle: const TextStyle(color: Colors.black),
                ),
                FilterChip(
                  label: const Text('Paid'),
                  onSelected: (isSelected) {
                    // TODO: Implement chip selection action
                  },
                  selected: false,
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blue,
                  labelStyle: const TextStyle(color: Colors.black),
                ),
                // Add more transaction types here
              ],
            ),
            const SizedBox(height: 16.0),
            const TransactionItem(
              logo: Icon(Icons.account_balance),
              payeeName: 'John Doe',
              accountNumber: '1234 5678 9012',
              amount: '\$500.00',
            ),
            const TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            // Add more transaction items here
            const TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            const TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            const TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            const TransactionItem(
              logo: Icon(Icons.attach_money),
              payeeName: 'Jane Smith',
              accountNumber: '9876 5432 1098',
              amount: '\$250.00',
            ),
            const TransactionItem(
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

  const TransactionItem({
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
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        accountNumber,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Text(
        amount,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
