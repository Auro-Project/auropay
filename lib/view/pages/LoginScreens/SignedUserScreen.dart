import '../../../view/widgets/CustomError.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../services/auth_service.dart';
import '../../widgets/Constants.dart';

class SignedUserScreen extends StatefulWidget {
  const SignedUserScreen({Key? key}) : super(key: key);

  @override
  _SignedUserScreenState createState() => _SignedUserScreenState();
}

class _SignedUserScreenState extends State<SignedUserScreen> {
  List<TextEditingController> passcodeControllers = [];
  int currentPasscodeIndex = 0;
  bool authenticated = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      passcodeControllers.add(TextEditingController());
    }
    Future.delayed(const Duration(seconds: 1), () {
      authenticateUser();
    });
  }

  Future<void> authenticateUser() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    var authenticated = await authService.authenticate();

    if (authenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // You might want to add a condition here to show the snackbar only if the user has not manually cancelled the authentication
      showGlobalSnackBar(context, 'Authentication failed');
    }
  }

  @override
  void dispose() {
    for (var controller in passcodeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void focusNextPasscodeField() {
    if (currentPasscodeIndex < passcodeControllers.length - 1) {
      currentPasscodeIndex++;
      FocusScope.of(context).nextFocus();
    }
  }

  void checkPasscode(int index, String value) async {
    if (index == 3 && value.isNotEmpty) {
      final authService = Provider.of<AuthService>(context, listen: false);
      List<String> passcode = passcodeControllers.map((controller) => controller.text).toList();
      if (await authService.confirmPasscode(passcode)) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid passcode')),
        );
      }
    }
  }

  void resetPasscode() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.resetPasscode();

    Navigator.pushReplacementNamed(context, '/createPasscode');
    showGlobalSnackBar(context, 'Now reset your passcode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/shapes/gradHM.png',
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pscode.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Hi, ${(AuthService.currentUser?.displayName ?? 'Auro User').split(' ')[0]}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF Pro Display',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 60),
                      Text(
                        'Enter your MPIN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'SF Pro Display',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++)
                            Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: border(context, borderRadius: 15),
                              child: TextField(
                                controller: passcodeControllers[i],
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                obscureText: true,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  checkPasscode(i, value);
                                  if (value.isNotEmpty && i < 3) {
                                    focusNextPasscodeField();
                                  }
                                },
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: resetPasscode,
                        child: Text(
                          'Forgot MPIN?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'SF Pro Display',
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                IconButton(
                  onPressed: () async {
                    final authService = Provider.of<AuthService>(context, listen: false);
                    var authenticated = await authService.authenticate();

                    setState(() {
                      authenticated = authenticated;
                    });

                    if (authenticated) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      showGlobalSnackBar(context, 'Authentication failed');
                    }
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons/faceid.svg',
                    width: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Use Face ID',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SF Pro Display',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
