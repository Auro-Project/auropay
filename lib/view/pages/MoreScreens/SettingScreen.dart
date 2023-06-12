import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auropay/view/Theme/theme_provider.dart';

import '../../Theme/appColors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
                  color: AppColors.textColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.textColor,
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
              Icons.notifications,
              color: AppColors.textColor,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.normal,
                color: AppColors.textColor,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          Divider(
            color: AppColors.textColor,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: AppColors.textColor,
            ),
            title: Text(
              'Language: $selectedLanguage', // Display the selected language
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.normal,
                color: AppColors.textColor,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Language',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.normal,
                        color: AppColors.textColor,
                      ),),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage = 'English'; // Update selected language
                              });
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text('English',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'SF-Pro-Display',
                                fontWeight: FontWeight.normal,
                                color: AppColors.textColor,
                              ),),
                          ),
                          const SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage = 'Spanish'; // Update selected language
                              });
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text('Spanish',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'SF-Pro-Display',
                                fontWeight: FontWeight.normal,
                                color: AppColors.textColor,
                              ),),
                          ),
                          // Add more language options as needed
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Divider(
            color: AppColors.textColor,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_sharp,
              color: AppColors.textColor,
            ),
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.normal,
                color: AppColors.textColor,
              ),
            ),
            onTap: () {},
          ),
          Divider(
            color: AppColors.textColor,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
