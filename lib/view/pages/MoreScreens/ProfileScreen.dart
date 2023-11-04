import 'dart:io';
import 'package:flutter_svg/svg.dart';

import '../../../view/widgets/AppButtons.dart';
import '../../../view/widgets/Constants.dart';
import '../../../view/widgets/CustomAppBar.dart';
import '../../../view/widgets/CustomError.dart';
import '../../../view/widgets/CustomField.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profilePhoto;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for email, full name, and phone number
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    _emailController.text = currentUser?.email ?? '';
    fetchCurrentUserDetails();
  }

  Future<void> fetchCurrentUserDetails() async {
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          final fullName = userSnapshot.get('fullName');
          final phoneNumber = userSnapshot.get('phoneNumber');
          setState(() {
            _fullNameController.text = fullName;
            _phoneNumberController.text = phoneNumber;
          });
        } else {
          print('User document does not exist');
        }
      } catch (e) {
        print('Error retrieving user data: $e');
      }
    }
  }

  void _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _profilePhoto = File(pickedImage.path);
      });
    }
  }

  Future<String?> _saveProfilePhoto() async {
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && _profilePhoto != null) {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('userProfilePhotos/$userId');

      final uploadTask = await storageRef.putFile(_profilePhoto!);

      if (uploadTask.state == firebase_storage.TaskState.success) {
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        // Update photo URL in Firebase Authentication
        await firebase_auth.FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);

        // Update photo URL in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'photoUrl': downloadUrl,
        });

        print('Profile photo updated successfully');
        showGlobalSnackBar(context, 'Profile photo updated successfully!');
        return downloadUrl;
      } else {
        print('Error uploading profile photo: ');
        showGlobalSnackBar(context, 'Failed to upload profile photo.');
      }
    }
    return null;
  }

  void _saveProfile() async {
    // Save the profile data to Firestore
    final profilePhotoUrl = await _saveProfilePhoto();
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'fullName': _fullNameController.text,
          'phoneNumber': _phoneNumberController.text,
          // Add profile photo url
          'profilePhotoUrl': profilePhotoUrl,
        });

        // Update the display name and photoURL of the Firebase user
        final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
        if (firebaseUser != null) {
          await firebaseUser.updateDisplayName(_fullNameController.text);
        }

        showGlobalSnackBar(context, 'Profile updated successfully!');
      } catch (e) {
        print('Error updating profile: $e');
        showGlobalSnackBar(context, 'Failed to update profile.');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final profilePhotoUrl =
        firebase_auth.FirebaseAuth.instance.currentUser?.photoURL;

    return Scaffold(
      appBar: myAppBar(context, 'Edit Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      //padding horizontal 20 vertical 40
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.camera),
                            title: const Text('Take a photo'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.image),
                            title: const Text('Choose from gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 1),
                  )),
              child: Stack(
                children: [
                  Container(
                    width: 160.0, // The width and height of the Container should be double the radius to simulate a CircleAvatar
                    height: 160.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: _profilePhoto != null
                          ? DecorationImage(
                        image: FileImage(_profilePhoto!),
                        fit: BoxFit.cover,
                      )
                          : (profilePhotoUrl != null
                          ? DecorationImage(
                        image: NetworkImage(profilePhotoUrl),
                        fit: BoxFit.cover,
                      )
                          : null),
                    ),
                    child: _profilePhoto == null && profilePhotoUrl == null
                        ? SvgPicture.asset(
                      'assets/images/icons/avtar.svg',
                      fit: BoxFit.cover, // This will cover the circle area
                    )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            myField(context, 'Full Name', _fullNameController, false),
            myField(context, 'Email address', _emailController, false),
            myField(context, 'Phone number', _phoneNumberController, false),
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: appButtonFunc(context, gradient(context),
                      margin: const EdgeInsets.only(bottom: 20)  ,
                      'Save profile', _saveProfile)),
            ),
          ],
        ),
      ),
    );
  }
}
