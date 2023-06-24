import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/appColors.dart';
import '../../Theme/theme_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                   color: Theme.of(context).cardColor,
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
          const SizedBox(height: 30),
          ListTile(
            leading: Icon(
              Icons.notifications_active,
             color: Theme.of(context).cardColor,
            ),
            title: Text(
              'Push Notifications',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.normal,
               color: Theme.of(context).cardColor,
              ),
            ),
            trailing: Switch(
              value: true, // Replace with your actual logic for push notifications
              onChanged: (value) {
                // Handle push notifications toggle
              },
              activeColor: Colors.deepPurpleAccent,
              inactiveTrackColor: Colors.grey,
            ),
            onTap: () {
              // Handle push notifications tap
            },
          ),
          Divider(
           color: Theme.of(context).cardColor,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(
              Icons.manage_accounts_sharp,
             color: Theme.of(context).cardColor,
            ),
            title: Text(
              'Manage Notifications',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.normal,
               color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Divider(
           color: Theme.of(context).cardColor,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(
              Icons.sms_sharp,
             color: Theme.of(context).cardColor,
            ),
            title: Text(
              'SMS Notifications',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.normal,
               color: Theme.of(context).cardColor,
              ),
            ),
            trailing: Switch(
              value: true, // Replace with your actual logic for SMS notifications
              onChanged: (value) {
                // Handle SMS notifications toggle
              },
              activeColor: Colors.deepPurpleAccent,
              inactiveTrackColor: Colors.grey,
            ),
            onTap: () {
              // Handle SMS notifications tap
            },
          ),
          Divider(
           color: Theme.of(context).cardColor,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(
              Icons.email_sharp,
             color: Theme.of(context).cardColor,
            ),
            title: Text(
              'Email Notifications',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.normal,
               color: Theme.of(context).cardColor,
              ),
            ),
            trailing: Switch(
              value: true, // Replace with your actual logic for email notifications
              onChanged: (value) {
                // Handle email notifications toggle
              },
              activeColor: Colors.deepPurpleAccent,
              inactiveTrackColor: Colors.grey,
            ),
            onTap: () {
              // Handle email notifications tap
            },
          ),
          Divider(
           color: Theme.of(context).cardColor,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
