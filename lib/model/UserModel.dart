import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


class UserModel {
  final String? uid;
  final String? email;
  final String? fullName;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final int? balance;

  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.balance,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      email: doc['email'] as String?,
      fullName: doc['fullName'] as String?,
      phoneNumber: doc['phoneNumber'] as String?,
      balance: doc['balance'] as int?,
      profilePhotoUrl: doc['profilePhotoUrl'] as String?,
    );
  }

  static Future<UserModel> fetchCurrentUserDetails() async {
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          UserModel user = UserModel.fromDocument(userSnapshot);
          return user;
        } else {
          print('User document does not exist');
          throw Exception('User not found');
        }
      } catch (e) {
        print('Error retrieving user data: $e');
        throw e;
      }
    } else {
      throw Exception('User not logged in');
    }
  }
}
