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
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      thickness: 6.0,
                      indent: 130.0,
                      endIndent: 130.0,
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 50.0),
                    appButtonFunc(context, gradient(context), 'Logout',
                        () async {
                      // Perform the logout action
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signOut();

                      // Remove the user login state
                      final storage = FlutterSecureStorage();
                      await storage.delete(key: 'isSignedIn');

                      // Close all screens and go back to the login screen
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/account', (Route<dynamic> route) => false);
                    }),
                    appButtonFunc(
                        margin: EdgeInsets.only(top: 20.0),
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

    Widget iconButton(
      String icon,
      String route, {
      double size = 42,
      Color? color,
      double iconSize = 15,
    }) {
      color ??= AppColors.accent1.shade200;
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: IconButton(
          icon: SvgPicture.asset(
            icon,
            height: iconSize,
            color: AppColors.textColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
        ),
      );
    }

    Widget iconButtonFunc(
      String iconPath, {
      double size = 42,
      Color? color,
      double iconSize = 15,
      required Function() onPressed,
    }) {
      color ??= AppColors.accent1.shade200;
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: IconButton(
          icon: SvgPicture.asset(
            iconPath,
            height: iconSize,
            color: AppColors.textColor,
          ),
          onPressed: onPressed,
        ),
      );
    }

    Widget buildRow(String title, String iconPath, String route) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Row(
          children: [
            iconButton(iconPath, route),
            SizedBox(width: 20.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: myAppBar(context, '',showLeadingIcon: false ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/shapes/gradHM.png',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(height: 100.0),
              Stack(
                children: [
                  Center(
                    heightFactor: 1.5,
                    child: Container(
                      width: 340,
                      height: 210,
                      decoration: gradient(context,
                          borderColor: AppColors.accent1.shade100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.0),
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: 'SF-Pro-Display',
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'FCW-675325',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'SF-Pro-Display',
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              iconButton(
                                  iconSize: 20,
                                  color: AppColors.primaryColor,
                                  size: 50,
                                  'assets/images/icons/report.svg',
                                  '/analytics'),
                              iconButton(
                                  iconSize: 18,
                                  color: AppColors.primaryColor,
                                  size: 50,
                                  'assets/images/icons/notify.svg',
                                  '/analytics'),
                              iconButton(
                                  iconSize: 18,
                                  color: AppColors.primaryColor,
                                  size: 50,
                                  'assets/images/icons/settings.svg',
                                  '/analytics'),
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
                        image: DecorationImage(
                          image: AssetImage('assets/images/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10.0),
              buildRow(
                  'Information', 'assets/images/icons/user.svg', '/proflie'),
              buildRow(
                  'Security', 'assets/images/icons/secure.svg', '/proflie'),
              buildRow(
                  'Contact Us', 'assets/images/icons/contact.svg', '/proflie'),
              buildRow('Chat Support', 'assets/images/icons/support.svg',
                  '/proflie'),
              //create a same way row but dark mode should be there with theme toggle from cupertinao
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent1.shade200,
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/icons/dark.svg',
                          height: 15.0,
                          color: AppColors.textColor,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SF-Pro-Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    CupertinoSwitch(
                      value: themeProvider.getThemeMode() == ThemeMode.dark,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//here is old code to give navigation
/*{

Widget  list (// Optional named parameter
    ) {
  return Column(
    children: [
      ListTile(
        leading: Icon(
          Icons.person,
          color: AppColors.textColor,
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.normal,
            
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      Divider(
        color: AppColors.textColor,
        indent: 16,
        endIndent: 16,
      ),
      ListTile(
        leading: Icon(
          Icons.help,
          color: AppColors.textColor,
        ),
        title: Text(
          'Help',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.normal,
            
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/help');
        },
      ),
      Divider(
        color: AppColors.textColor,
        indent: 16,
        endIndent: 16,
      ),
      ListTile(
        leading: Icon(
          Icons.settings,
          color: AppColors.textColor,
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.normal,
            
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/settings');
        },
      ),
      Divider(
        color: AppColors.textColor,
        indent: 16,
        endIndent: 16,
      ),
      ListTile(
        leading: Icon(
          Icons.nightlight_round,
          color: AppColors.textColor,
        ),
        title: Text(
          'Dark Mode',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.normal,
            
          ),
        ),
        trailing: Switch(
          value: themeProvider.currentTheme == ThemeMode.dark,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
          activeColor: Colors.deepPurpleAccent,
          inactiveTrackColor: Colors.grey,
        ),
        onTap: () {
          themeProvider.toggleTheme();
        },
      ),
      Divider(
        color: AppColors.textColor,
        indent: 16,
        endIndent: 16,
      ),
      ListTile(
        leading: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.normal,
            color: Colors.red,
          ),
        ),
        onTap: () {
          _showLogoutConfirmationBottomSheet(context);
        },
      ),
    ],
  );
}
 }
  */
