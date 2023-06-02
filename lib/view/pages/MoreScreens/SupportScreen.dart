import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
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
                  'Support',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                    color: themeProvider.textColor,
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
          const SizedBox(height: 200),
          Expanded(
            child: ListView(
              children: const [
                TextBubble(
                  sender: 'Sender',
                  message: 'Hello, I am facing issues using this app.\nCan you help me?',
                  isSentByUser: true,
                ),
                TextBubble(
                  sender: 'Receiver',
                  message: 'Hey, yes of course I can help you.\nWhat\'s the issue you are facing?',
                  isSentByUser: false,
                ),
                // Add more text bubbles here for the conversation
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt_rounded),
                color: themeProvider.textColor,
                onPressed: () {
                  // Handle camera icon press
                },
              ),
              IconButton(
                icon: const Icon(Icons.attach_file),
                color: themeProvider.textColor,
                onPressed: () {
                  // Handle document icon press
                },
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: themeProvider.textColor),
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: themeProvider.textColor.withOpacity(0.54)),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_voice),
                color: themeProvider.textColor,
                onPressed: () {
                  // Handle voice input icon press
                },
              ),
              IconButton(
                icon: const Icon(Icons.send),
                color: themeProvider.textColor,
                onPressed: () {
                  // Handle send icon press
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool isSentByUser;

  const TextBubble({
    required this.sender,
    required this.message,
    required this.isSentByUser,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isSentByUser ? Colors.deepPurpleAccent : Colors.grey,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeProvider.textColor,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                message,
                style: TextStyle(
                  color: themeProvider.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return MaterialApp(
            theme: themeProvider.theme,
            home: SupportScreen(),
          );
        },
      ),
    ),
  );
}
