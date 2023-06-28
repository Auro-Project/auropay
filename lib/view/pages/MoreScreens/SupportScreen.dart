import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/theme_provider.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Support'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
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
               color: Theme.of(context).primaryColor,
                onPressed: () {
                  // Handle camera icon press
                },
              ),
              IconButton(
                icon: const Icon(Icons.attach_file),
               color: Theme.of(context).primaryColor,
                onPressed: () {
                  // Handle document icon press
                },
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Theme.of(context).primaryColor,),
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor,),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_voice),
               color: Theme.of(context).primaryColor,
                onPressed: () {
                  // Handle voice input icon press
                },
              ),
              IconButton(
                icon: const Icon(Icons.send),
               color: Theme.of(context).primaryColor,
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
                 color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                message,
                style: TextStyle(
                 color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

