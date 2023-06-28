import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/local_auth_api.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> confirmPasscode(List<String> passcode) async {
    String? savedPasscode = await storage.read(key: 'passcode');
    return passcode.join() == savedPasscode;
  }

  Future<void> resetPasscode() async {
    // Clear the existing passcode
    await storage.delete(key: 'passcode');
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false);
    // Perform any other sign-out related actions
  }

  Future<bool> authenticate() async {
    // Use LocalAuthApi to authenticate
    final authenticate = await LocalAuthApi.authenticate();
    return authenticate;
  }

  Future<bool> isUserSignedIn() async {
    String? isSignedIn = await storage.read(key: 'isSignedIn');
    return isSignedIn != null && isSignedIn == 'true';
  }

  Future<void> sendOtp(String phoneNumber, Function onCodeSent) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception('Failed to send OTP: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      throw Exception('Send OTP Error: $e');
    }
  }

  Future<void> signUp(String fullName, String email, String password, String phoneNumber) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final CollectionReference users = _firestore.collection('users');
      await users.doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      if (kDebugMode) {
        throw Exception('Signup failed: $e');
      }
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User signed in successfully
      return userCredential;
    } catch (e) {
      // Forward the error for handling
      throw e;
    }
  }


  Future<UserCredential> signInWithCredential(
      PhoneAuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential> verifyOTP(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }
}

class PasscodeService {
  final storage = const FlutterSecureStorage();

  Future<void> savePasscode(List<String> passcodeParts) async {
    String passcode = passcodeParts.join();
    await storage.write(key: 'passcode', value: passcode);
  }

  Future<bool> confirmPasscode(List<String> passcodeParts) async {
    String passcode = passcodeParts.join();
    String? savedPasscode = await storage.read(key: 'passcode');
    return passcode == savedPasscode;
  }

  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await FlutterSecureStorage().write(key: 'isSignedIn', value: 'true');
  }
}