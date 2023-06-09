
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomField.dart';
import '../providers/theme_provider.dart';
import 'ConfirmOTPScreenD.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
final _formKey = GlobalKey<FormState>();
final TextEditingController fullNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController =
TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

void signUp(String phoneNumber, String password) async {
  try {
    UserCredential userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: phoneNumber, // Use email field to store phone number
      password: password,
    );

    // Store additional user data in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'fullName': fullNameController.text.trim(),
      'email': emailController.text.trim(),
      'phoneNumber': phoneNumber,
      'password' : confirmPasswordController,

      // Add any additional fields you want to store
    });

    if (kDebugMode) {
      print('Signup successful!');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Signup failed: $e');
    }
  }
}

void registerUser() async {
  final String fullName = fullNameController.text.trim();
  final String email = emailController.text.trim();
  final String password = passwordController.text.trim();
  final String confirmPassword = confirmPasswordController.text.trim();
  final String phoneNumber = phoneNumberController.text.trim();

  if (_formKey.currentState!.validate()) {
    // Perform phone number verification here

    // If phone number verification is successful, proceed with registration
    signUp(phoneNumber, password);
  }
}


class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageController _pageController = PageController(initialPage: 0);
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mailController.dispose();
    phoneNumberController.dispose();
    // passController.dispose();
    // confirmPassController.dispose();
    _pageController.dispose();
    super.dispose();
  }
  String? validatePassword(String? value) {
    if (value != passController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: myAppBar(context, 'Sign Up'),
      backgroundColor: themeProvider.backgroundColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FirstStep(
            nameController: nameController,
            mailController: mailController,
            passController: passController,
            confirmPassController: confirmPassController,
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          SecondStep(
            phoneNumberController: phoneNumberController,
          ),
        ],
      ),
    );
  }
}

class FirstStep extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController mailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;


  final VoidCallback onNext;


  const FirstStep({
    Key? key,
    required this.nameController,
    required this.mailController,
    required this.passController,
    required this.confirmPassController,
    required this.onNext,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            myField(context, 'Full Name', nameController, false),
            myField(context, 'Email Address', mailController, false),
            myField(context, 'Password', passController, true),
            myField(context, 'Confirm Password', confirmPassController, true),

          ],
        ),
        Expanded(

          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              // child as elevated button
              child: appButtonFunc(context, gradient(context), "Next", onNext),
            ),
          ),
        ),
      ],
    );
  }


// Rest of the code for myField and myPhone functions

}

class SecondStep extends StatefulWidget {
  const SecondStep({Key? key, required TextEditingController phoneNumberController}) : super(key: key);

  @override
  _SecondStepState createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode = '+91'; // Default country code

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void sendOTP() async {
    String phoneNumber = phoneNumberController.text.trim();
    String fullPhoneNumber = '$countryCode$phoneNumber';

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieval of verification code completed
        // This callback is optional
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification failed
        if (kDebugMode) {
          print('Verification Failed: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Navigate to the ConfirmActivationCode screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmOTPScreen(
              phoneNumber: phoneNumber,
              countryCode: countryCode,
              verificationId: verificationId,
              onVerificationComplete: (PhoneAuthCredential credential) async {
                try {
                  // Sign in with the credential
                  UserCredential userCredential =
                  await FirebaseAuth.instance.signInWithCredential(credential);

                  // Store additional user data in Firestore
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userCredential.user!.uid)
                      .set({
                    'phoneNumber': phoneNumber,
                    // Add any additional fields you want to store
                  });

                  if (kDebugMode) {
                    print('Phone number stored in Firestore successfully!');
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Failed to store phone number in Firestore: $e');
                  }
                }
              },
            ),
          ),
        );




      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Code auto-retrieval timed out
      },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start, // Aligns children to the left
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Text(
              'Phone number',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w500,
                color: Colors.white38,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      countryCode,
                      style: TextStyle(
                        color: themeProvider.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: themeProvider.textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Enter your phone number', // Placeholder text
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 18,
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Please confirm the country code and enter your phone\n number',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w500,
                color: Colors.white38,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child:
                appButtonFunc(context, gradient(context), 'Send Code',sendOTP),
                // appButton(context, gradient(context), 'send', '/createPasscode')

              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Rest of the code for myField and myPhone functions

Widget myPhone(BuildContext context, String label, TextEditingController controller,String countryCode) {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w500,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  countryCode,
                  style: TextStyle(
                    color: themeProvider.textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: themeProvider.textColor),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

      ],
    ),
  );
}


class OTPScreen extends StatefulWidget {
  final String verificationId;

  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // OTP verification successful
      // Add your desired code here, e.g., navigate to the home screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      if (kDebugMode) {
        print('OTP Verified');
      }
    } catch (e) {
      // OTP verification failed
      if (kDebugMode) {
        print('OTP Verification Failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the OTP sent to your phone',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16.0),
                decoration: const InputDecoration(
                  labelText: 'OTP',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOTP,
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
