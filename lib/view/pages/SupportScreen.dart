import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(70.0),
            child: Text(
              'Support',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
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
                icon: const Icon(Icons.camera, color: Colors.white),
                onPressed: () {
                  // Handle camera icon press
                },
              ),
              IconButton(
                icon: const Icon(Icons.attach_file, color: Colors.white),
                onPressed: () {
                  // Handle document icon press
                },
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_voice, color: Colors.white),
                onPressed: () {
                  // Handle voice input icon press
                },
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
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
  runApp(MaterialApp(
    home: SupportScreen(),
  ));
}
