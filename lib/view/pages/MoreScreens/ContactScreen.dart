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
  List<Map<String, dynamic>> allContacts = [];
  List<Map<String, dynamic>> favoriteContacts = [];
  List<Map<String, dynamic>> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    // Pseudo contacts data
    allContacts = [
      {
        'name': 'John Doe',
        'isFavorite': false,
        'photo': 'assets/images/avatar.png',
        'username': '@johndoe',
      },
      {
        'name': 'Jane Smith',
        'isFavorite': true,
        'photo': 'assets/images/avatar.png',
        'username': '@janesmith',
      },
      {
        'name': 'Michael Johnson',
        'isFavorite': false,
        'photo': 'assets/images/avatar.png',
        'username': '@michaeljohnson',
      },
      {
        'name': 'Emily Davis',
        'isFavorite': false,
        'photo': 'assets/images/avatar.png',
        'username': '@emilydavis',
      },
      {
        'name': 'William Brown',
        'isFavorite': false,
        'photo': 'assets/images/avatar.png',
        'username': '@williambrown',
      },
      {
        'name': 'Olivia Wilson',
        'isFavorite': false,
        'photo': 'assets/images/avatar.png',
        'username': '@oliviawilson',
      },
    ];

    favoriteContacts = allContacts.where((contact) => contact['isFavorite']).toList();
    filteredContacts = allContacts; // Initialize filteredContacts with allContacts
  }

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
                    filterContacts();
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

  void toggleFavorite(int index) {
    setState(() {
      allContacts[index]['isFavorite'] = !allContacts[index]['isFavorite'];
      favoriteContacts = allContacts.where((contact) => contact['isFavorite']).toList();
      filterContacts();
    });
  }

  void filterContacts() {
    if (searchQuery.isEmpty) {
      filteredContacts = favoriteContacts.isNotEmpty ? favoriteContacts : allContacts;
    } else {
      filteredContacts = allContacts
          .where((contact) =>
          contact['name'].toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      'Contacts',
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
          const SizedBox(
            height: 50,
          ),
          buildSearchBar(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    searchQuery = '';
                    filteredContacts = allContacts; // Update filteredContacts
                  });
                },
                child: const Text(
                  'All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    searchQuery = '';
                    filteredContacts = favoriteContacts;
                  });
                },
                child: const Text(
                  'Favorites',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(contact['photo']),
                    radius: 20,
                  ),
                  title: Text(
                    contact['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    contact['username'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white38,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      contact['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                      color: contact['isFavorite'] ? Colors.red : Colors.white,
                    ),
                    onPressed: () => toggleFavorite(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
