import 'package:auropay/view/widgets/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:auropay/view/Theme/theme_provider.dart';
import '../../Theme/appColors.dart';
import '../../widgets/CustomAppBar.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Color getTextColor() {
      return themeProvider.currentTheme == ThemeMode.dark ? Colors.white : Colors.black;
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
                          decoration: border(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            onPressed: () async {
                              // Perform the logout action
                              FirebaseAuth auth = FirebaseAuth.instance;
                              await auth.signOut();

                              // Remove the user login state
                              final storage = FlutterSecureStorage();
                              await storage.delete(key: 'isSignedIn');

                              // Close all screens and go back to the login screen
                              Navigator.of(context).pushNamedAndRemoveUntil('/account', (Route<dynamic> route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
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
      appBar: myAppBar(context, 'More'),
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.person,
                color: AppColors.textColor,
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
              color: AppColors.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: AppColors.textColor,
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
              color: AppColors.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: AppColors.textColor,
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
              color: AppColors.textColor,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.nightlight_round,
                color: AppColors.textColor,
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
                value: themeProvider.currentTheme == ThemeMode.dark,
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
              color: AppColors.textColor,
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