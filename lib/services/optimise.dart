// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../services/local_auth_api.dart';
//
// class AuthService {
//   final FlutterSecureStorage storage;
//   final FirebaseAuth _auth;
//   final FirebaseFirestore _firestore;
//
//   // Singleton pattern to create a single instance of AuthService
//   static final AuthService _singleton = AuthService._internal(
//     storage: const FlutterSecureStorage(),
//     auth: FirebaseAuth.instance,
//     firestore: FirebaseFirestore.instance,
//   );
//
//   // Factory method to return the same instance
//   factory AuthService() {
//     return _singleton;
//   }
//
//   // Named constructor
//   AuthService._internal({required this.storage, required FirebaseAuth auth, required this._firestore})
//       : _auth = auth;
//
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool('isSignedIn', false);
//     } catch (e) {
//       throw Exception('Failed to sign out: ${e.message}');
//     }
//   }
//
//   Future<bool> authenticate() async {
//     final authenticate = await LocalAuthApi.authenticate();
//     return authenticate;
//   }
//
//   Future<bool> isUserSignedIn() async {
//     String? isSignedIn = await storage.read(key: 'isSignedIn');
//     return isSignedIn != null && isSignedIn == 'true';
//   }
//
//   Future<void> sendOtp(String phoneNumber, Function onCodeSent) async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) {
//           _auth.signInWithCredential(credential);
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           throw Exception('Failed to send OTP: ${e.message}');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           onCodeSent(verificationId);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       throw Exception('Send OTP Error: $e');
//     }
//   }
//
//   Future<void> signUp(String fullName, String email, String password, String phoneNumber) async {
//     try {
//       final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       final CollectionReference users = _firestore.collection('users');
//       await users.doc(userCredential.user!.uid).set({
//         'fullName': fullName,
//         'email': email,
//         'phoneNumber': phoneNumber,
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         throw Exception('Signup failed: $e');
//       }
//     }
//   }
//
//   Future<UserCredential> signIn(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       // User signed in successfully
//       return userCredential;
//     } catch (e) {
//       // Forward the error for handling
//       throw e;
//     }
//   }
//
//   Future<UserCredential> signInWithCredential(PhoneAuthCredential credential) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       await storage.write(key: 'isSignedIn', value: 'true');
//       return userCredential;
//     } catch (e) {
//       // Forward the error for handling
//       throw e;
//     }
//   }
//
//   Future<UserCredential> verifyOTP(String verificationId, String smsCode) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsCode,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       await storage.write(key: 'isSignedIn', value: 'true');
//       return userCredential;
//     } catch (e) {
//       // Forward the error for handling
//       throw e;
//     }
//   }
// }
//
// class PasscodeService {
//   final FlutterSecureStorage storage;
//
//   // Singleton pattern to create a single instance of PasscodeService
//   static final PasscodeService _singleton = PasscodeService._internal(storage: const FlutterSecureStorage());
//
//   // Factory method to return the same instance
//   factory PasscodeService() {
//     return _singleton;
//   }
//
//   // Named constructor
//   PasscodeService._internal({required this.storage});
//
//   Future<void> savePasscode(List<String> passcodeParts) async {
//     String passcode = passcodeParts.join();
//     await storage.write(key: 'passcode', value: passcode);
//   }
//
//   Future<bool> confirmPasscode(List<String> passcodeParts) async {
//     String passcode = passcodeParts.join();
//     String? savedPasscode = await storage.read(key: 'passcode');
//     return passcode == savedPasscode;
//   }
// }
