import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> signIn(String email, String password) async {
  // This is just an example, your actual sign-in code may look different
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  // When sign-in is successful, save to secure storage
  await FlutterSecureStorage().write(key: 'isSignedIn', value: 'true');
}

Future<void> signOut() async {
  // This is just an example, your actual sign-out code may look different
  await FirebaseAuth.instance.signOut();

  // When sign-out is successful, update secure storage
  await FlutterSecureStorage().write(key: 'isSignedIn', value: 'false');
}
