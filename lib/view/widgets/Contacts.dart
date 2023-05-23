import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String avatar;

  Contact({required this.name, required this.avatar});
}

class ContactListBottomSheet extends StatefulWidget {
  @override
  _ContactListBottomSheetState createState() => _ContactListBottomSheetState();
}

class _ContactListBottomSheetState extends State<ContactListBottomSheet> {
  List<Contact> contacts = [
    Contact(name: "John Doe", avatar: "assets/images/avatar.png"),
    Contact(name: "Jane Smith", avatar: "assets/images/avatar.png"),
    Contact(name: "Alex Johnson", avatar: "assets/images/avatar.png"),
    // Add more contacts here
  ];

  List<Contact> filteredContacts = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
  }

  void filterContacts(String query) {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
          contact.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: filterContacts,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                    AssetImage(filteredContacts[index].avatar),
                  ),
                  title: Text(filteredContacts[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),),
                  onTap: () {
                    // Handle contact selection
                    // You can close the bottom sheet here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


