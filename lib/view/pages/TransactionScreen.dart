import 'package:auropay/view/Theme/theme_provider.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Theme/appColors.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryColor,
      appBar: myAppBar(context, 'Transaction'),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
              "assets/images/shapes/gradHM.png",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(15.0),
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
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'All',
                  style: TextStyle(color: AppColors.textColor, fontSize: 16.0),
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
        style: const TextStyle(color: AppColors.textColor),
      ),
      subtitle: Text(
        accountNumber,
        style: const TextStyle(color: AppColors.textColor),
      ),
      trailing: Text(
        amount,
        style: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}