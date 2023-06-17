import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/appColors.dart';
import '../../Theme/theme_provider.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomTile.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryColor,
      appBar: myAppBar(context, "Privacy Policy"),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
