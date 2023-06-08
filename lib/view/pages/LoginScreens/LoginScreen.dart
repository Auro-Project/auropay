// import 'package:auropay/view/pages/LoginScreens/ConfirmOTPScreen.dart';
// import 'package:auropay/view/widgets/CustomAppBar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../widgets/AppButtons.dart';
// import '../../widgets/Constants.dart';
// import '../providers/theme_provider.dart';
// import 'ConfirmOTPScreenD.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController phoneNumberController = TextEditingController();
//   String countryCode = '+91'; // Default country code
//
//   @override
//   void dispose() {
//     phoneNumberController.dispose();
//     super.dispose();
//   }
//
//   void sendOTP() async {
//     String phoneNumber = phoneNumberController.text.trim();
//     String fullPhoneNumber = '$countryCode$phoneNumber';
//
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: fullPhoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) {
//         // Auto-retrieval of verification code completed
//         // This callback is optional
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         // Verification failed
//         if (kDebugMode) {
//           print('Verification Failed: ${e.message}');
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         // Navigate to the ConfirmActivationCode screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ConfirmOTPScreen(
//               phoneNumber: phoneNumber,
//               countryCode: countryCode,
//               verificationId: verificationId,
//             ),
//           ),
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Code auto-retrieval timed out
//       },
//       timeout: const Duration(seconds: 60),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Scaffold(
//       appBar: myAppBar(context, 'Sign in'),
//       backgroundColor: themeProvider.backgroundColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the left
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(top: 30, left: 16, right: 16),
//             child: Text(
//               'Phone number',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontFamily: 'SF-Pro-Display',
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white38,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
//             child: Row(
//               children: [
//                 Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF3A3A3B),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       countryCode,
//                       style: TextStyle(
//                         color: themeProvider.textColor,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3A3A3B),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: TextField(
//                       controller: phoneNumberController,
//                       keyboardType: TextInputType.phone,
//                       style: TextStyle(color: themeProvider.textColor),
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                         hintText: 'Enter your phone number', // Placeholder text
//                         hintStyle: TextStyle(
//                           color: Colors.white38,
//                           fontSize: 18,
//                           fontFamily: 'SF-Pro-Display',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 40),
//                 child: appButton(context, gradient(context), 'Send Code', '/confirmOTP'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }