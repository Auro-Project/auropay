import 'package:flutter/material.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);

  @override
  _NotifScreenState createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  int selectedCategoryIndex = 0;

  final List<String> categories = ['All', 'Payments', 'Balance', 'Alerts'];

  final List<List<NotificationItem>> notifications = const [
    [
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'You have a new payment of \$50.',
      ),
      NotificationItem(
        icon: Icons.payment,
        iconColor: Colors.red,
        message: 'Payment of \$25 was deducted from your account.',
      ),
      NotificationItem(
        icon: Icons.account_balance_wallet,
        iconColor: Colors.green,
        message: 'Your account balance is now \$100.',
      ),
      NotificationItem(
        icon: Icons.warning,
        iconColor: Colors.orange,
        message: 'Important: Please update your payment method.',
      ),
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Notification message 1',
      ),
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Notification message 2',
      ),
    ],
    [
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Payment notification 1',
      ),
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Payment notification 2',
      ),
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Payment notification 3',
      ),
    ],
    [
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Balance notification 1',
      ),
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Balance notification 2',
      ),
    ],
    [
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Alert notification 1',
      ),
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Alert notification 2',
      ),
      NotificationItem(
        icon: Icons.notifications,
        iconColor: Colors.blue,
        message: 'Alert notification 3',
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(70.0),
            child: Center(
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SF-Pro-Display',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                categories.length,
                    (index) => NotificationCategory(
                  title: categories[index],
                  isSelected: index == selectedCategoryIndex,
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: notifications[selectedCategoryIndex],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCategory extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const NotificationCategory({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String message;

  const NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotifScreen(),
  ));
}