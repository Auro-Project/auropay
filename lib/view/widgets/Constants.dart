import 'package:flutter/material.dart';

BoxDecoration gradient(BuildContext context) => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      gradient: const LinearGradient(
        colors: [
          Color(0xFFA4AAEE),
          Color(0xFF8FB4EC)],
        stops: [0.5, 1],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(-5, 5),
          spreadRadius: 3,
          blurRadius: 10,
        ),
      ],
    );

BoxDecoration border(BuildContext contex,
{
  double borderRadius = 20,
  Color borderColor = Colors.white70,
  Color colorbg = Colors.black12,
}) => BoxDecoration(
  color: colorbg,
  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
  border: Border.all(
    color: borderColor,
    width: 1,
  ),
);


