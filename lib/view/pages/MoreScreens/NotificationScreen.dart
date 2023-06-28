import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/appColors.dart';
import '../../Theme/theme_provider.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomTile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Notifications'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          buildRow(context,
            'Manage Notifications', 'assets/images/icons/notify.svg',
            '/notifications',),
          switchRow(
              context, 'Push Notifications', 'assets/images/icons/notify.svg',
              valueDefault: false, changedValue: (valueDefault) {}
          ),
          switchRow(
              context, 'SMS Notifications', 'assets/images/icons/sms.svg',
              valueDefault: false, changedValue: (valueDefault) {}
          ),
          switchRow(
              context, 'Email Notifications', 'assets/images/icons/mail.svg',
              valueDefault: false, changedValue: (valueDefault) {}
          ),
        ],
      ),
    );
  }
}
