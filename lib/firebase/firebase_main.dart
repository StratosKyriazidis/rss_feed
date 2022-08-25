import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMain with ChangeNotifier {
  static FirebaseMain of(BuildContext context, {bool listen = true}) {
    return Provider.of<FirebaseMain>(context, listen: listen);
  }

  bool? loggedIn;
  FirebaseAuth? auth;
  var db = FirebaseFirestore.instance;

  FirebaseMain() {
    auth = FirebaseAuth.instance;
  }

  void checkLoginStatus() {
    auth!.authStateChanges().listen((User? user) {
      if (user == null) {
        loggedIn = false;
      } else {
        loggedIn = true;
      }
      notifyListeners();
    });
  }

  Future<void> anonymousSignin() async {
    UserCredential userCredential = await auth!.signInAnonymously();
    final user = <String, dynamic>{'id': userCredential.user?.uid};

    DocumentReference docIdRef =
        db.collection("users").doc(userCredential.user?.uid);
    docIdRef.get().then((doc) {
      if (!doc.exists) {
        db.collection("users").doc(userCredential.user?.uid).set(user);
      }
    });
  }

  void callAnonymousSignin() {
    anonymousSignin();
    notifyListeners();
  }

  Future<String> emailLogin(String email, String password) async {
    try {
      UserCredential userCredential = await auth!
          .signInWithEmailAndPassword(email: email, password: password);
      final user = <String, dynamic>{'id': userCredential.user?.uid};

      DocumentReference docIdRef =
          db.collection("users").doc(userCredential.user?.uid);
      docIdRef.get().then((doc) {
        if (!doc.exists) {
          db.collection("users").doc(userCredential.user?.uid).set(user);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      } else if (e.code == 'wrong-password') {
        return 'wrong-password';
      }
    }
    notifyListeners();
    return 'all-clear';
  }

  Future<String> emailSignup(String email, String password) async {
    try {
      UserCredential userCredential = await auth!
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = <String, dynamic>{'id': userCredential.user?.uid};

      DocumentReference docIdRef =
          db.collection("users").doc(userCredential.user?.uid);
      docIdRef.get().then((doc) {
        if (!doc.exists) {
          db.collection("users").doc(userCredential.user?.uid).set(user);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        return 'email-already-in-use';
      }
    } catch (e) {
      return e.toString();
    }
    notifyListeners();
    return 'all-clear';
  }

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
    return await auth!.signInWithCredential(credential);
  }

  Future<void> callGoogleSignin() async {
    var userCredential = await signInWithGoogle();
    final user = <String, dynamic>{'id': userCredential.user?.uid};

    DocumentReference docIdRef =
        db.collection("users").doc(userCredential.user?.uid);
    docIdRef.get().then((doc) {
      if (!doc.exists) {
        db.collection("users").doc(userCredential.user?.uid).set(user);
      }
    });

    notifyListeners();
  }

  Future<void> signOut() async {
    await auth!.signOut();
    notifyListeners();
  }
}
