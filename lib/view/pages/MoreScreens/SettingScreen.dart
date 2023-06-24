import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:auropay/view/widgets/CustomTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: myAppBar(context, 'App Settings'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 20),
          buildRow(context,
              'Notifications', 'assets/images/icons/notify.svg',
              '/notifications',),
          buildRowFunc(
            context, 'Language', 'assets/images/icons/notify.svg', onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Select Language',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.normal,
                       color: Theme.of(context).cardColor,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage =
                                    'English'; // Update selected language
                              });
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              'English',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'SF-Pro-Display',
                                fontWeight: FontWeight.normal,
                               color: Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage =
                                    'Spanish'; // Update selected language
                              });
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              'Spanish',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'SF-Pro-Display',
                                fontWeight: FontWeight.normal,
                               color: Theme.of(context).cardColor,
                              ),
                            ),
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
          switchRow(
              context, 'ScreenShot Protection', 'assets/images/icons/notify.svg',
              valueDefault: false, changedValue: (valueDefault) {})
        ],
      ),
    );
  }
}
