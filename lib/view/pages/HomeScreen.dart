import 'dart:convert';
import 'package:auropay/model/Transaction.dart';
import 'package:auropay/view/Theme/appColors.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomShape.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/UserData.dart';
import 'FutureEnhancements/AnalyticsScreen.dart';
import 'MoreScreens/MoreScreen.dart';
import '../widgets/BottomNavBar.dart';
import '../../view/pages/TransactionScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Future<String> fetchCurrentUserFullName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userData['fullName'];
    }
    return '';
  }

  static Future<UserData> loadJsonData() async {
    String jsonData = await rootBundle.loadString('lib/data/user.json');
    Map<String, dynamic> jsonMap = json.decode(jsonData);
    return UserData.fromJson(jsonMap);
  }

  static Widget _homepage(BuildContext context, UserData userData) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    final String? profilePhotoUrl = currentUser?.photoURL;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: profilePhotoUrl != null
                                ? NetworkImage(profilePhotoUrl)
                                : const AssetImage("assets/images/avatar.png")
                                    as ImageProvider<Object>?,
                            //AssetImage("assets/images/avatar.png"),
                          ),
                        ),
                        Text(
                          "Hi, ${userData.name}",
                          style: TextStyle(
                           color: Theme.of(context).cardColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/notifs');
                            },
                            icon: SvgPicture.asset(
                              "assets/images/icons/notify.svg",
                              height: 23,
                            ),
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
                        strokeColor: Colors.white.withOpacity(0.8),
                        fillColor: Colors.white54.withOpacity(0.01),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.05),
                           Text(
                            "Your Balance",
                            style: TextStyle(
                             color: Theme.of(context).cardColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            userData.balance,
                            style: TextStyle(
                             color: Theme.of(context).cardColor,
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
                                 color: Theme.of(context).cardColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                     Text(
                                      "Valid Thru",
                                      style: TextStyle(
                                       color: Theme.of(context).cardColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      userData.expireDate,
                                      style: TextStyle(
                                       color: Theme.of(context).cardColor,
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
                        '/withdraw',
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
                      color: Theme.of(context).cardColor.withOpacity(0.0),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Recent Transactions",
                                style: TextStyle(
                                 color: Theme.of(context).cardColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: width * 0.08),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/transactions');
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
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
                                     color: Theme.of(context).cardColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.date,
                                    style: TextStyle(
                                     color: Theme.of(context).cardColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: Text(
                                    item.amount,
                                    style: TextStyle(
                                     color: Theme.of(context).cardColor,
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
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          Container(
            decoration: gradient(context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(200, 50)),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: SvgPicture.asset(
                  icon,
                  height: 30,
                  color: Theme.of(context).cardColor,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, route),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
             color: Theme.of(context).cardColor,
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
            return const CircularProgressIndicator();
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
