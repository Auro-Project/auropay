import 'dart:convert';
import '../../../view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/Transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String filter = 'all';

  static Future<List<ListItem>> loadJsonData(String filter) async {
    String jsonData = await rootBundle.loadString('lib/data/user.json');
    Map<String, dynamic> jsonMap = json.decode(jsonData);

    List<dynamic> transactionsJson = jsonMap['transactions'];
    List<ListItem> transactions =
        transactionsJson.map((item) => ListItem.fromJson(item)).toList();

    if (filter != 'all') {
      transactions = transactions.where((item) => item.type == filter).toList();
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
                  child: FutureBuilder<List<ListItem>>(
                    future: loadJsonData(filter),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
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
                                 color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                item.date,
                                style: TextStyle(
                                 color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: Text(
                                item.amount,
                                style: TextStyle(
                                 color: Theme.of(context).primaryColor,
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
