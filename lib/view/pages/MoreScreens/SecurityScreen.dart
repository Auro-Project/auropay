import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/appColors.dart';
import '../../Theme/theme_provider.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomTile.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Security"),
      body: Column(
        children: [
          const SizedBox(height: 120,),
          buildRow(
            context,
            'Change Passcode',
            'assets/images/icons/secure.svg',
            '/createPasscode',
          ),
        ],
      ),
    );
  }
}
