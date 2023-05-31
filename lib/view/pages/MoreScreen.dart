import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auropay/view/pages/providers/theme_provider.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Color getTextColor() {
      return themeProvider.isDarkMode ? Colors.white : Colors.black;
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: getTextColor(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                 Padding(
                  padding: EdgeInsets.all(70.0),
                  child: Text(
                    'More',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.w600,
                      color: getTextColor(),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: themeProvider.textColor,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                // Handle profile onTap
              },
            ),
            Divider(
              color: themeProvider.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.mail,
                color: themeProvider.textColor,
              ),
              title: Text(
                'Invitation',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                // Handle invitation onTap
              },
            ),
            Divider(
              color: themeProvider.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.contacts,
                color: themeProvider.textColor,
              ),
              title: Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                // Handle contacts onTap
              },
            ),
            Divider(
              color: themeProvider.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: themeProvider.textColor,
              ),
              title: Text(
                'Help',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                // Handle help onTap
              },
            ),
            Divider(
              color: themeProvider.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: themeProvider.textColor,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                // Handle settings onTap
              },
            ),
            Divider(
              color: themeProvider.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.nightlight_round,
                color: themeProvider.textColor,
              ),
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
                activeColor: Colors.deepPurpleAccent,
                inactiveTrackColor: Colors.grey,
              ),
              onTap: () {
                themeProvider.toggleTheme();
              },
            ),
            Divider(
              color: themeProvider.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                // Handle logout onTap
              },
            ),
          ],
        ),
      ),
    );
  }
}
