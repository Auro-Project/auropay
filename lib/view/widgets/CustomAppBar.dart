
import 'package:flutter/material.dart';

AppBar myAppBar(
    BuildContext context,
    String title,
    ) {
  return AppBar(
    backgroundColor: const Color(0xFF161616),
    elevation:0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'SF Pro Display',
      ),
    ),
    centerTitle: true,
  );
}