import 'package:auropay/view/widgets/CustomShape.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../view/pages/AnalyticsScreen.dart';
import 'MoreScreens/MoreScreen.dart';
import '../widgets/nav_bar/BottomNavBar.dart';
import '../../view/pages/TransactionScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static Widget _homepage(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/HomePage.png"),
          Center(
            child: Column(
              children: [
                SizedBox(height: height * 0.08),
                //create top status bar with avatar with name and notification button on right corner
                const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/avatar.png"),
                        ),
                      ),
                      Text(
                        "Hi, Zara",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                //create reactangle card with balance and currency, logo left bottom of card, expiry right bottom corner
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.25,
                  width: width * 0.9,
                  child: CustomPaint(
                    painter: CustomShape(),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.05),
                        const Text(
                          "Your Balance",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        const Text(
                          "₹2,500.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SvgPicture.asset(
                                "assets/images/icons/Logo.svg",
                                height: 45,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Column(
                                children: [
                                  Text(
                                    "Valid Thru",
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "MM/YY",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //create 4 cards with icons and text
                SizedBox(height: height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _homeButton(context, 'assets/images/icons/add.svg', 'TopUp',
                        '/send'),
                    _homeButton(context, 'assets/images/icons/send.svg', 'Send',
                        '/send'),
                    _homeButton(context, 'assets/images/icons/request.svg',
                        'Request', '/send'),
                    _homeButton(context, 'assets/images/icons/withdraw.svg',
                        'Withdraw', '/send'),
                  ],
                ),
                SizedBox(height: height * 0.02),
                //create a ListBuilder for recent transactions
                SizedBox(
                  height: height * 0.42,
                  width: width * 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color(0xff1E1E1E),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Recent Transactions",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: width * 0.2),
                            const Text(
                              "View All",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return const ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage("assets/images/avatar.png"),
                                ),
                                title: Text(
                                  "Zara Doe",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Text(
                                  "12 Jub, 12:00 PM",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Text(
                                  "-₹200.00",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _homeButton(
      BuildContext context, String icon, String text, String route) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0x12ffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 17),
              child: SvgPicture.asset(
                icon,
                height: 30,
                color: Colors.white70,
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, route),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _homepage(context),
      const AnalyticsScreen(),
      const TransactionScreen(),
      const MoreScreen(),
    ];
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
    );
  }
}
