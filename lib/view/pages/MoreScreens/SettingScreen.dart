import 'package:auropay/view/widgets/CustomAppBar.dart';
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
      appBar: myAppBar(context, 'Settings'),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: AppColors.textColor,
            ),
            title: const Text(
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
          const Divider(
            color: AppColors.textColor,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: AppColors.textColor,
            ),
            title: Text(
              'Language: $selectedLanguage', // Display the selected language
              style: const TextStyle(
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
                    title: const Text('Select Language',
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
                            child: const Text('English',
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
                            child: const Text('Spanish',
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
          const Divider(
            color: AppColors.textColor,
            indent: 16,
            endIndent: 16,
          ),

        ],
      ),
    );
  }
}
