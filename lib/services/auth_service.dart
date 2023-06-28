import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/local_auth_api.dart';

class AuthService {
  final storage = const FlutterSecureStorage();

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
}
