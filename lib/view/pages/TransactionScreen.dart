import 'package:auropay/view/pages/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        children: [
          //Image.asset("assets/images/HomePage.png"),
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Transaction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro Display',
                        color: themeProvider.textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
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
        ],
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