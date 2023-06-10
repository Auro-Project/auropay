import 'dart:convert';

import 'package:auropay/model/Transaction.dart';
import 'package:auropay/view/Theme/appColors.dart';
import 'package:auropay/view/Theme/theme_provider.dart';
import 'package:auropay/view/widgets/CustomShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/UserData.dart';
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

  static Future<UserData> loadJsonData() async {
    String jsonData = await rootBundle.loadString('lib/data/user.json');
    Map<String, dynamic> jsonMap = json.decode(jsonData);
    return UserData.fromJson(jsonMap);
  }

  static Widget _homepage(BuildContext context, UserData userData) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset("assets/images/shapes/gradHM.png"),
            Padding(
              padding: EdgeInsets.symmetric(
                // horizontal: width * 0.02,
                vertical: height * 0.08,
              ),
              child: Column(
                children: [
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
                          "Hi, ${userData.name}",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.textColor,
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
                          Text(
                            "Your Balance",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                              userData.balance,
                            style: TextStyle(
                              color: AppColors.textColor,
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
                                  color: AppColors.textColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Valid Thru",
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      userData.expireDate,
                                      style: TextStyle(
                                        color: AppColors.textColor,
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
                      color: AppColors.primaryColor.withOpacity(0.85),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Recent Transactions",
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: width * 0.08),
                              Text(
                                "View All",
                                style: TextStyle(
                                  color: AppColors.accent1,
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
                              itemCount: userData.transactions.length,
                              itemBuilder: (context, index) {
                                ListItem item = userData.transactions[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(item.userImage),
                                  ),
                                  title: Text(
                                    item.name,
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.date,
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: Text(
                                    item.amount,
                                    style: TextStyle(
                                      color: AppColors.textColor,
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
              backgroundColor: AppColors.textColor.withOpacity(0.9),
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
                color: AppColors.primaryColor,
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
              color: AppColors.textColor,
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
    FutureBuilder<UserData>(
      future: loadJsonData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _homepage(context, snapshot.data!);
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    ),
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
