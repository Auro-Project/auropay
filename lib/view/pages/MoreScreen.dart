import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle the button press
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          ListTile(
            title: Text('Profile'),
            textColor: Colors.white,
            leading: Icon(Icons.person, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Invitation'),
            textColor: Colors.white,
            leading: Icon(Icons.mail, color: Colors.white),
            onTap: () {
              // Navigate to the invitation screen
            },
          ),
          Divider(),
          ListTile(
            title: Text('Contacts'),
            leading: Icon(Icons.contacts, color: Colors.white),
            textColor: Colors.white,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ContactsScreen();
                },
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Help'),
            textColor: Colors.white,
            leading: Icon(Icons.help, color: Colors.white),
            onTap: () {
              // Navigate to the help screen
            },
          ),
          Divider(),
          ListTile(
            title: Text('Settings'),
            textColor: Colors.white,
            leading: Icon(Icons.settings, color: Colors.white),
            onTap: () {
              // Navigate to the settings screen
            },
          ),
          Divider(),
          ListTile(
            title: Text('Dark Mode'),
            textColor: Colors.white,
            leading: Icon(Icons.brightness_4, color: Colors.white),
            trailing: Switch(

              value: true, // Set the value based on the dark mode status
              onChanged: (value) {
                // Implement the logic to toggle dark mode
              },
              activeColor: Colors.purple,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(Icons.logout, color: Colors.white),
            onTap: () {
              // Implement the logic to log out the user
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<String> allContacts = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Williams',
    'Charlie Brown',
  ];

  List<String> favoriteContacts = [
    'John Doe',
    'Alice Johnson',
  ];

  Set<String> selectedContacts = Set<String>();

  void toggleFavorite(String contact) {
    setState(() {
      if (favoriteContacts.contains(contact)) {
        favoriteContacts.remove(contact);
      } else {
        favoriteContacts.add(contact);
      }
    });
  }

  bool isFavorite(String contact) {
    return favoriteContacts.contains(contact);
  }

  List<String> filteredContacts = [];

  void searchContacts(String query) {
    setState(() {
      filteredContacts = allContacts
          .where((contact) => contact.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: searchContacts,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: const Text(
                    'Favorites',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Implement logic for adding a new contact
                  },
                  child: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              children: favoriteContacts
                  .map(
                    (contact) => Chip(
                  label: Text(contact),
                  avatar: GestureDetector(
                    onTap: () => toggleFavorite(contact),
                    child: Icon(
                      Icons.favorite,
                      color:
                      isFavorite(contact) ? Colors.red : Colors.grey,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text(
                'All Contacts',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Implement logic for displaying all contacts
              },
            ),
            ...filteredContacts.map(
                  (contact) => ListTile(
                title: Text(contact),
                trailing: GestureDetector(
                  onTap: () => toggleFavorite(contact),
                  child: Icon(
                    Icons.favorite,
                    color: isFavorite(contact) ? Colors.red : Colors.grey,
                  ),
                ),
                onTap: () {
                  // Implement logic for selecting a contact
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle the button press
            },
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage:
                  AssetImage('assets/profile_picture.jpg'), // Replace with your own profile picture
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: TextButton(

                  onPressed: () {
                    // Implement logic for changing the profile picture
                  },
                  child: Text('Change Profile Picture'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF7D7AFF)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'First Name',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Last Name',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Text(
                'Date of birth',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Text(
                'Username',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Phone Number',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
