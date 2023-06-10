
import 'package:auropay/view/Theme/appColors.dart';
import 'package:flutter/material.dart';

AppBar myAppBar(
    BuildContext context,
    String title,
    ) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation:0,
    leading: IconButton(
      icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textColor,
      ),
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
        color: AppColors.textColor,
      ),
    ),
    centerTitle: true,
  );
}