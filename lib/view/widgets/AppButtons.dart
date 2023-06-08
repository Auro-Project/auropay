import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Container appButton(
    BuildContext context,
    BoxDecoration styleButton,
    String title,
    String route, {
      String? iconPath,
    }) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.88,
    height: MediaQuery.of(context).size.height * 0.065,
    decoration: styleButton,
    child: ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ),
  );
}

Container appButtonFunc(
    BuildContext context,
    BoxDecoration styleButton,
    String title,
    Function() onPressed,
    {String? iconPath,}
    ) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.88,
    height: MediaQuery.of(context).size.height * 0.065,
    decoration: styleButton,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ),
  );
}
