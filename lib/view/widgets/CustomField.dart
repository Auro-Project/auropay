import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/providers/theme_provider.dart';
import 'Constants.dart';

Column myField(BuildContext context,
    String label, TextEditingController controller, bool obscure,
    { String? truePhrase, String? falsePhrase }
    ) {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w500,
          color: Colors.white38,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 360,
        height: 50,
        decoration: border(context,
            colorbg: Colors.grey.withOpacity(0.3),
            borderColor: Colors.transparent,
            borderRadius: 10),
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(color: themeProvider.textColor),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return truePhrase;
            }
            return falsePhrase;
          },
        ),
      ),
      const SizedBox(height: 20),

    ],
  );
}
