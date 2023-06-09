import 'package:auropay/view/pages/providers/theme_provider.dart';
import 'package:auropay/view/widgets/CustomShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'FutureEnhancements/AnalyticsScreen.dart';
import 'MoreScreens/MoreScreen.dart';
import '../widgets/BottomNavBar.dart';
import '../../view/pages/TransactionScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static Widget _homepage(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset("assets/images/HomePage.png"),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.08,
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
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
                            color: themeProvider.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.notifications,
                            color: themeProvider.textColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    height: height * 0.25,
                    width: width * 0.9,
                    child: CustomPaint(
                      painter: CustomShape(
                        strokeColor: Colors.white.withOpacity(0.7),
                        fillColor: Colors.white54.withOpacity(0.01),
                      ),
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
                          Text(
                            "₹2,500.00",
                            style: TextStyle(
                              color: themeProvider.textColor,
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
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Valid Thru",
                                      style: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "MM/YY",
                                      style: TextStyle(
                                        color: themeProvider.textColor,
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
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _homeButton(
                        context,
                        'assets/images/icons/add.svg',
                        'TopUp',
                        '/topup',
                      ),
                      _homeButton(
                        context,
                        'assets/images/icons/withdraw.svg',
                        'Withdraw',
                        '/send',
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
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
                              Text(
                                "View All",
                                style: TextStyle(
                                  color: themeProvider.textColor,
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
                                return ListTile(
                                  leading: const CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                    AssetImage("assets/images/avatar.png"),
                                  ),
                                  title: Text(
                                    "Zara Doe",
                                    style: TextStyle(
                                      color: themeProvider.textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  subtitle: const Text(
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
                                      color: themeProvider.textColor,
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
      ),
    );
  }

  static Widget _homeButton(
      BuildContext context,
      String icon,
      String text,
      String route,
      ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: 140,
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0x12ffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
                minimumSize: const Size(200, 50)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeProvider.textColor,
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
      AnalyticsScreen(),
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
