import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMain with ChangeNotifier {
  static FirebaseMain of(BuildContext context, {bool listen = true}) {
    return Provider.of<FirebaseMain>(context, listen: listen);
  }

  bool? loggedIn;

  FirebaseMain() {
    FirebaseAuth auth = FirebaseAuth.instance;
  }

  void checkLoginStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        loggedIn = false;
      } else {
        loggedIn = true;
      }
    });
    notifyListeners();
  }

  Future<void> anonymousSignin() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
  }

  void callAnonymousSignin() {
    anonymousSignin();
    notifyListeners();
  }

  void foo() {}

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void callGoogleSignin() {
    signInWithGoogle();
    notifyListeners();
  }
}
