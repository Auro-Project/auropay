import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/appColors.dart';
import '../../Theme/theme_provider.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Access the ThemeProvider
    return Scaffold(
      backgroundColor: AppColors.primaryColor, // Apply the background color from the theme
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro Display',
                        color: AppColors.textColor, // Apply the text color from the theme
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                // Handle change profile photo onPressed
              },
              child: const Text(
                'Change Profile Photo',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'SF Pro Display',
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First Name',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.textColor, // Apply the text color from the theme
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter first name',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Last Name',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.textColor, // Apply the text color from the theme
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter last name',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Date of Birth',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.textColor, // Apply the text color from the theme
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter date of birth',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.textColor, // Apply the text color from the theme
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter email address',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
