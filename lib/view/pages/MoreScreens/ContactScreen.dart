import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/appColors.dart';
import '../../Theme/theme_provider.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomTile.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Contact Us"),
      body: Column(
        children: [
          const SizedBox(height: 120,),
          buildRow(
            context,
            'Privacy Policy',
            'assets/images/icons/privacy.svg',
            '/policy',
          ),
          buildRow(
            context,
            'Chat Support',
            'assets/images/icons/support.svg',
            '/support',
          ),
          buildRow(
            context,
            'FAQ',
            'assets/images/icons/support.svg',
            '/faq',
          ),
        ],
      ),
    );
  }
}
