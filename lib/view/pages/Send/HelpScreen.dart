import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Help'),
    backgroundColor: Colors.black,
    actions: [
    IconButton(
    icon: Icon(Icons.more_vert),
    onPressed: () {
    // Handle the button press
    },
    ),
    ],
    ),
    backgroundColor: Colors.black,
    body: ListView(
    children: [
    ListTile(
    title: Text('Popular Questions'),
    textColor: Colors.white,
    leading: Icon(Icons.question_answer, color: Colors.white),
    onTap: () {
    },
    ),
    Divider(),
    ListTile(
    title: Text('Chat with support'),
    textColor: Colors.white,
    leading: Icon(Icons.headphones_outlined, color: Colors.white),
    onTap: () {
    // Navigate to the invitation screen
    },

    )

     ] )
    );
  }
}
