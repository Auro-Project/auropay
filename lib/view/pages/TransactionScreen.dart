import 'dart:convert';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/Transaction.dart';
import '../Theme/appColors.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key});

  static Future<List<ListItem>> loadJsonData() async {
    String jsonData = await rootBundle.loadString('lib/data/user.json');
    Map<String, dynamic> jsonMap = json.decode(jsonData);

    // Assuming the transaction data is stored under the 'transactions' key in the JSON
    List<dynamic> transactionsJson = jsonMap['transactions'];
    List<ListItem> transactions =
        transactionsJson.map((item) => ListItem.fromJson(item)).toList();
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryColor,
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
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: AppColors.textColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
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
                        // TODO: Implement chip selection action
                      },
                      selected: false,
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue,
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
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
                Expanded(
                  child: FutureBuilder<List<ListItem>>(
                    future:
                        loadJsonData(), // Replace with your own future function
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While the future is loading, show a progress indicator
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // If an error occurred while fetching the data, display an error message
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        // If the data is successfully fetched, build the ListView.builder
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            ListItem item = snapshot.data![index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(item.userImage),
                              ),
                              title: Text(
                                item.name,
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                item.date,
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: Text(
                                item.amount,
                                style: TextStyle(
                                  color: AppColors.textColor,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
