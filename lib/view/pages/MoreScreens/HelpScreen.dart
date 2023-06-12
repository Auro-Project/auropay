import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/appColors.dart';
import '../../Theme/theme_provider.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Help',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.textColor, // Apply the text color from the theme
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
          SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpItem(
                icon: Icons.question_answer,
                title: 'FAQ',
                onTap: () {
                  // Navigate to FAQ page
                },
                themeProvider: themeProvider, // Pass the themeProvider to the _buildHelpItem function
              ),
              SizedBox(height: 14),
              _buildHelpItem(
                icon: Icons.chat_bubble,
                title: 'Chat with Support',
                onTap: () {
                  Navigator.pushNamed(context, '/support');
                },
                themeProvider: themeProvider, // Pass the themeProvider to the _buildHelpItem function
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ThemeProvider themeProvider, // Add themeProvider as a required parameter
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textColor), // Apply the text color from the theme
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'SF Pro Display',
                color: AppColors.textColor, // Apply the text color from the theme
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
