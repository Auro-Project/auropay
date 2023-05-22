import 'package:flutter/material.dart';
import '../../view/pages/AnalyticsScreen.dart';
import '../../view/pages/MoreScreen.dart';
import '../widgets/nav_bar/BottomNavBar.dart';
import '../../view/pages/TransactionScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static Widget _homepage(){
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/HomePage.png"),
          const Center(
            child: Text(
              "Home",
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> _screens = [
    _homepage(),
    const AnalyticsScreen(),
    const TransactionScreen(),
    const MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
    );
  }
}
