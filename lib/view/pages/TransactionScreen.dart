import 'dart:convert';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/Transaction.dart';
import '../../services/auth_service.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String filter = 'all';

  Future<List<myTransaction>> fetchTransactionsFromFirebase() async {
    List<myTransaction> userSpecificTransactions = [];

    // Assuming you have a method to get the current user's ID
    String userId = AuthService.currentUser!.uid; // Make sure this matches how you retrieve the user's ID

    // Reference to the user's transactions subcollection in Firestore
    var userTransactionsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions');

    // Get the snapshot of the data in Firestore
    var snapshot = await userTransactionsCollection.get();

    // Convert each document into a `myTransaction` object and add it to the list
    for (var doc in snapshot.docs) {
      userSpecificTransactions.add(myTransaction.fromMap(doc.data() as Map<String, dynamic>));
    }

    return userSpecificTransactions;
  }


  Future<List<myTransaction>> fetchTransactions() async {
    List<myTransaction> transactions = await fetchTransactionsFromFirebase();

    if (filter != 'all') {
      transactions = transactions.where((transaction) {
        return transaction.type.toString().split('.').last == filter;
      }).toList();
    }

    return transactions;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, 'Transaction', showLeadingIcon: false),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            "assets/images/shapes/gradHM.png",
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // TODO: Implement microphone button action
                        },
                      ),
                       Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      onSelected: (isSelected) {
                        setState(() {
                          filter = 'all';
                        });
                      },
                      selected: filter == 'all',
                     backgroundColor: Theme.of(context).canvasColor,
                      selectedColor: Theme.of(context).hintColor,
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                    FilterChip(
                      label: const Text('Credit'),
                      onSelected: (isSelected) {
                        setState(() {
                          filter = 'credit';
                        });
                      },
                      selected: filter == 'credit',
                     backgroundColor: Theme.of(context).canvasColor,
                      selectedColor: Theme.of(context).hintColor,
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                    FilterChip(
                      label: const Text('Debit'),
                      onSelected: (isSelected) {
                        setState(() {
                          filter = 'debit';
                        });
                      },
                      selected: filter == 'debit',
                     backgroundColor: Theme.of(context).canvasColor,
                      selectedColor: Theme.of(context).hintColor,
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Expanded(
              child: FutureBuilder<List<myTransaction>>(
                future: fetchTransactions(), // Call the new fetchTransactions method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No transactions found.'));
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        myTransaction transaction = snapshot.data![index];
                        // Modify this part to display transaction details correctly
                        IconData transactionIconData = transaction.type == TransactionType.credit
                            ? Icons.arrow_downward // example icon for credit
                            : Icons.arrow_upward; // example icon for debit

                        // Format the date and amount properly here
                        String formattedDate = DateFormat.yMMMd().format(transaction.timestamp); // make sure to import 'package:intl/intl.dart';
                        String formattedAmount = '\$${transaction.amount.toStringAsFixed(2)}'; // Assuming amount is a double

                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            // You might want to display a default image or an icon here
                            backgroundColor: Theme.of(context).hintColor,
                            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: Icon(transactionIconData),
                          ),
                          title: Text(
                            transaction.fromUserId, // Use the transaction's description
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: Text(
                            formattedDate, // Use the formatted transaction date
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Text(
                            formattedAmount, // Use the formatted amount
                            style: TextStyle(
                              color: transaction.type == TransactionType.credit ? Colors.green : Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
