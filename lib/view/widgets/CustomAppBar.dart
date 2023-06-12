import 'package:auropay/view/Theme/appColors.dart';
import 'package:flutter/material.dart';

AppBar myAppBar(
    BuildContext context,
    String title,
    {bool showLeadingIcon = true}  // Optional named parameter
    ) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: showLeadingIcon
        ? IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.textColor,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    )
        : null,  // If showLeadingIcon is false, leading will be null
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
