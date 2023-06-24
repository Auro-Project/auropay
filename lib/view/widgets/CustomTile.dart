import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Theme/appColors.dart';

Widget iconButton(
    BuildContext context,
    String icon,
    String route, {
      double size = 42,
      Color? color,
      double iconSize = 15,
    }) {
  color ??= AppColors.accent1.shade200;
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: IconButton(
      icon: SvgPicture.asset(
        icon,
        height: iconSize,
        color: Theme.of(context).cardColor,
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
    ),
  );
}

Widget iconButtonFunc(
    BuildContext context,
    String iconPath, {
      double size = 42,
      Color? color,
      double iconSize = 15,
      required Function() onPressed,
    }) {
  color ??= AppColors.accent1.shade200;
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: IconButton(
      icon: SvgPicture.asset(
        iconPath,
        height: iconSize,
        color: Theme.of(context).cardColor,
      ),
      onPressed: onPressed,
    ),
  );
}

Widget buildRow(
    BuildContext context,
    String title,
    String iconPath,
    String route, {
      Function()? onPressed,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
    child: Row(
      children: [
        iconButton(context, iconPath, route),
        const SizedBox(width: 20.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
          ),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
        ),
      ],
    ),
  );
}

Widget buildRowFunc(
    BuildContext context,
    String title,
    String iconPath, {
      required Function() onPressed,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
    child: Row(
      children: [
        iconButtonFunc(context, iconPath, onPressed: onPressed),
        const SizedBox(width: 20.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
          ),
          onPressed: onPressed,
        ),
      ],
    ),
  );
}

Widget switchRow(
    BuildContext context,
    String title,
    String iconPath, {
      required bool valueDefault,
      required Function(bool)? changedValue,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent1.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              iconPath,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        CupertinoSwitch(
          value: valueDefault,
          onChanged: changedValue,
        )
      ],
    ),
  );
}
