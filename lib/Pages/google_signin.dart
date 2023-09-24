
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gadget_express/components/cart_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gadget_express/home.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late CartManager cartManager;

  SignInWithGoogleButton({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled the sign-in.

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // User successfully signed in with Google, store user data in Firestore.
        //    await _storeUserDataInFirestore(user);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(cartManager: cartManager,), // Replace "HomePage" with your desired next page.
          ),
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> _storeUserDataInFirestore(User user) async {
    // Store user data in Firestore.
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    await userRef.set({
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoURL,
      // Add any other user data you want to store.
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signInWithGoogle(context),
      child: const Text('Sign in with Google'),
    );
  }
}
