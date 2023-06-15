import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:auropay/view/Theme/theme_provider.dart';
import '../../Theme/appColors.dart';
import '../../widgets/CustomAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../widgets/CustomTile.dart';


class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    void _showLogoutConfirmationBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height *
                    0.5, // Set desired height here
              ),
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Divider(
                      thickness: 6.0,
                      indent: 130.0,
                      endIndent: 130.0,
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    appButtonFunc(context, gradient(context), 'Logout',
                        () async {
                      // Perform the logout action
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signOut();

                      // Remove the user login state
                      const storage = FlutterSecureStorage();
                      await storage.delete(key: 'isSignedIn');

                      // Close all screens and go back to the login screen
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/account', (Route<dynamic> route) => false);
                    }),
                    appButtonFunc(
                        margin: const EdgeInsets.only(top: 20.0),
                        context,
                        border(context),
                        'Cancel', () {
                      Navigator.of(context).pop();
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }


    final height = MediaQuery.of(context).size.height;
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    final String? profilePhotoUrl = currentUser?.photoURL;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: myAppBar(context, '', showLeadingIcon: false),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/shapes/gradHM.png',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(height: 80.0),
              Stack(
                children: [
                  Center(
                    heightFactor: 1.5,
                    child: Container(
                      width: 340,
                      height: 210,
                      decoration: border(context,
                          borderColor: AppColors.accent1.shade100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60.0),
                          const Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: 'SF-Pro-Display',
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'FCW-675325',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'SF-Pro-Display',
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              iconButton(
                                context,
                                  iconSize: 20,
                                  color: AppColors.primaryColor,
                                  size: 50,
                                  'assets/images/icons/user.svg',
                                  '/profile'),
                              iconButton(
                                  context,
                                  iconSize: 18,
                                  color: AppColors.primaryColor,
                                  size: 50,
                                  'assets/images/icons/designcard.svg',
                                  '/designcard'),
                              iconButton(
                                  context,
                                  iconSize: 18,
                                  color: AppColors.primaryColor,
                                  size: 50,
                                  'assets/images/icons/notify.svg',
                                  '/notifs'),
                              iconButtonFunc(
                                  iconSize: 18,
                                  color: AppColors.primaryColor,
                                  size: 50,
                                  'assets/images/icons/logout.svg',
                                  onPressed: () {
                                _showLogoutConfirmationBottomSheet(context);
                              })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                        border: Border.all(
                          color: AppColors.accent1.shade400,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: profilePhotoUrl != null
                            ? NetworkImage(profilePhotoUrl)
                            : const AssetImage("assets/images/avatar.png")
                        as ImageProvider<Object>?,
                        //AssetImage("assets/images/avatar.png"),
                      ),
                    ),
                  ),
                ],
              ),
              //SizedBox(height: 10.0),
              SizedBox(
                height: height*0.5,
                child: SingleChildScrollView(
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      switchRow(
                          context, 'Dark Mode', 'assets/images/icons/dark.svg',
                        valueDefault : themeProvider.getThemeMode() == ThemeMode.dark,
                        changedValue: (valueDefault) {
                          themeProvider.toggleTheme();
                        },
                      ),
                      buildRow(context,'App Settings', 'assets/images/icons/settings.svg', '/settings'),
                      buildRow(context,'Security', 'assets/images/icons/secure.svg', '/proflie'),
                      buildRow(context,'Contact Us', 'assets/images/icons/contact.svg', '/proflie'),
                      buildRow(context,'Privacy Policy', 'assets/images/icons/privacy.svg', '/proflie'),
                      buildRow(context,'Chat Support', 'assets/images/icons/support.svg', '/support'),
                      buildRow(context,'FAQ', 'assets/images/icons/support.svg', '/support'),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

