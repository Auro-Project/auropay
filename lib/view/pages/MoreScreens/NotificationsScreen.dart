
import '../../../view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Theme/appColors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationItem> notifications;

  @override
  void initState() {
    super.initState();

    notifications = [
      NotificationItem(
        icon: Icons.notifications,
      iconColor: AppColors.accentColor,
        message: 'Payment of \$25 was deducted for papers.',
        paymentName: 'Stationary',
        time: DateTime.now(),
      ),
      NotificationItem(
        icon: Icons.payment,
      iconColor: AppColors.accentColor,
        message: 'Payment of \$25 was deducted for food item.',
        paymentName: 'Food',
        time: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationItem(
        icon: Icons.account_balance_wallet,
      iconColor: AppColors.accentColor,
        message: 'Your account balance is now \$100.',
        paymentName: 'Balance',
        time: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NotificationItem(
        icon: Icons.warning,
      iconColor: AppColors.accentColor,
        message: 'Important: Please update your payment method.',
        paymentName: 'Alert',
        time: DateTime.now().subtract(const Duration(days: 5)),
      ),
      NotificationItem(
        icon: Icons.notifications,
      iconColor: AppColors.accentColor,
        message: 'Notification message 1',
        paymentName: 'Other',
        time: DateTime.now().subtract(const Duration(days: 7)),
      ),
      NotificationItem(
        icon: Icons.notifications,
      iconColor: AppColors.accentColor,
        message: 'Notification message 2',
        paymentName: 'Other',
        time: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: myAppBar(context, 'Notifications'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: NotificationItemRow(notification: notification),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String message;
  final String paymentName;
  final DateTime time;

  const NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.message,
    required this.paymentName,
    required this.time,
  });
}

class NotificationItemRow extends StatelessWidget {
  final NotificationItem notification;

  const NotificationItemRow({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');
    final today = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final lastWeek = DateTime.now().subtract(const Duration(days: 7));
    final notificationTime = notification.time;

    String timeText;
    if (formatter.format(notificationTime) == formatter.format(today)) {
      timeText = 'Today';
    } else if (formatter.format(notificationTime) == formatter.format(yesterday)) {
      timeText = 'Yesterday';
    } else if (notificationTime.isAfter(lastWeek)) {
      timeText = 'A week ago';
    } else {
      timeText = formatter.format(notificationTime);
    }

    return Row(
      children: [
        Icon(
          notification.icon,
          color: notification.iconColor,
          size: 24.0,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.paymentName,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                ),
              ),
              Text(
                notification.message,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
        Text(
          timeText,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: NotificationsScreen(),
    ),
  );
}
