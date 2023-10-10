import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'Components/user_provider.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Authentication methods
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = authResult.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Other authentication methods
}