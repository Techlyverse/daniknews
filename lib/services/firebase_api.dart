import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../auth/welcome_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;

// Future<User?> signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//   final AuthCredential authCredential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   User? user = (await auth.signInWithCredential(authCredential)).user;
//   debugPrint(auth.currentUser!.displayName);
//   return user;
// }

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  final AuthCredential authCredential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

  return userCredential.user;
}

Future logOut(BuildContext context) async {
  await auth.signOut().then((value) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  });
}
