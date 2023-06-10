import 'dart:io';

import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:auropay/view/widgets/CustomField.dart';
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

  void _saveProfile() async {
    // Save the profile data to Firestore
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'fullname': _fullNameController.text,
          'phonenumber': _phoneNumberController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
          ),
        );
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profilePhotoUrl =
        firebase_auth.FirebaseAuth.instance.currentUser?.photoURL;
    final email = _emailController.text;

    return Scaffold(
      appBar: myAppBar(context, 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
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
                  shape:CircleBorder(
                    side: BorderSide(color: Colors.white, width: 1),
                  )
              ),
              child: CircleAvatar(

                radius: 80,
                backgroundImage: _profilePhoto != null
                    ? FileImage(_profilePhoto!) as ImageProvider<Object>?
                    : (profilePhotoUrl != null
                    ? NetworkImage(profilePhotoUrl) as ImageProvider<Object>?
                    : null),
              ),
            ),
            const SizedBox(height: 16),


            myField(context, 'Full Name', _fullNameController, false),

            myField(context, 'Email address', _emailController, false),
            myField(context, 'phone number', _phoneNumberController, false),


            const SizedBox(height: 20),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: appButtonFunc(context, gradient(context), 'Save profile', _saveProfile)),
            ),
            

          ],
        ),
      ),
    );
  }
}
