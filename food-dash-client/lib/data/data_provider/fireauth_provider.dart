import 'package:food_dash/data/model/response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<LoginResponse> login(
      {@required String email, @required String password}) async {
    try {
      final userCredentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return LoginResponse(user: userCredentials.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // 'No user found for that email.'
      } else if (e.code == 'wrong-password') {
        // 'Wrong password provided for that user.'
      }

      return LoginResponse(message: e.message);
    }
  }

  Future<RegisterResponse> register(
      {@required String email, @required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return RegisterResponse(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }

      return RegisterResponse(message: e.message);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future signOut() async {
    try {
      //If the user sign in with Google, we need to sign out google too
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await signOutGoogle();
      }

      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Stream<User> authStateChange() {
    return _auth.authStateChanges();
  }

  Future<User> googleSignIn() async {
    try {
      final googleSignInAuthentication =
          await (await _googleSignIn.signIn()).authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final userCredentials = await _auth.signInWithCredential(credential);

      return userCredentials.user;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      print("Google User Signed Out");
    } catch (e) {
      debugPrint(e);
    }
  }
}
