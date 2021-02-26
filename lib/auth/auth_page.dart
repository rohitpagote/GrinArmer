import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/home/components/demo_file.dart';
import 'package:distributer_application/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'showErrDialog.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

Future<void> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await auth.signInWithCredential(credential);

    FirebaseUser user = await auth.currentUser();
    print(user.uid);

    return Future.value(true);
  }
}

// instead of returning true or false
// returning user to directly access UserID
Future<FirebaseUser> signin(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    // return Future.value(true);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid email address");
        break;
      case 'ERROR_WRONG_PASSWORD':
        showErrDialog(context, "Wrong password");
        break;
      case 'ERROR_USER_NOT_FOUND':
        showErrDialog(context, "User not Found");
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, "User disabled");
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, "Too many requests");
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        showErrDialog(context, "Operation not allowed");
        break;
    }
    // since we are not actually continuing after displaying errors
    // the false value will not be returned
    // hence we don't have to check the valur returned in from the signin function
    // whenever we call it anywhere
    return Future.value(null);
  }
}

// change to Future<FirebaseUser> for returning a user
Future<FirebaseUser> signUp(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return Future.value(user);
    // return Future.value(true);
  } catch (error) {
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        showErrDialog(context, "Email already exists");
        break;
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid email address");
        break;
      case 'ERROR_WEAK_PASSWORD':
        showErrDialog(context, "Please choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}

Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();
  print(user.providerData[1].providerId);
  if (user.providerData[1].providerId == 'google.com') {
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}

Future<int> sendPasswordWithResetEmail(
    String email, BuildContext context) async {
  try {
    await auth.sendPasswordResetEmail(email: email);
    return Future.value(1);
  } catch (e) {
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid email address");
        break;
      case 'ERROR_WRONG_PASSWORD':
        showErrDialog(context, "Wrong password");
        break;
      case 'ERROR_USER_NOT_FOUND':
        showErrDialog(context, "User not Found");
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, "User disabled");
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, "Too many requests");
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        showErrDialog(context, "Operation not allowed");
        break;
    }
    return Future.value(null);
  }
}
