import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
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

    void _showLogoutConfirmationBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.5, // Set desired height here
              ),
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.w600,
                        color: getTextColor(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.normal,
                        color: getTextColor(),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: border(context) ,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(  horizontal: 20.0),
                            child: TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'SF-Pro-Display',
                                  fontWeight: FontWeight.normal,
                                  color: getTextColor(),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: gradient(context),
                          child: ElevatedButton(
                            onPressed: () {
                              // Perform the logout action
                              // ...
                              // Close all screens and go back to the login screen
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                              minimumSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'SF-Pro-Display',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
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
                  padding: const EdgeInsets.all(70.0),
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
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
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
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/help');
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
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: getTextColor(),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
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
                  fontSize: 18,
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
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.normal,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                _showLogoutConfirmationBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
