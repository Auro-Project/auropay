import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String searchQuery = '';
  bool showFavorites = false;

  Widget buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.white38,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pseudo contacts data
    List<Map<String, dynamic>> allContacts = [
      {'name': 'John Doe', 'phone': '1234567890'},
      {'name': 'Jane Smith', 'phone': '9876543210'},
      // Add more contacts as needed
    ];

    List<Map<String, dynamic>> favoriteContacts = [
      {'name': 'John Doe', 'phone': '1234567890'},
      // Add more favorite contacts as needed
    ];

    // Filter contacts based on search query
    List<Map<String, dynamic>> filteredContacts = allContacts
        .where((contact) =>
        contact['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                    color: Colors.white,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        child: Text('Menu Item 1'),
                      ),
                      const PopupMenuItem(
                        child: Text('Menu Item 2'),
                      ),
                      const PopupMenuItem(
                        child: Text('Menu Item 3'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          buildSearchBar(),
          const SizedBox(height: 30,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFavorites = false;
                    });
                  },
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: showFavorites ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFavorites = true;
                    });
                  },
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: showFavorites ? Colors.blue : Colors.white,
                    ),
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
