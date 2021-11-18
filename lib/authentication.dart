import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<User> signInWithGoogle({BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'Error occurred using Google Sign In. Try again.',
          ),
        );
      }
    }

    return user;
  }

  static SnackBar customSnackBar({String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<void> signOut({BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();

      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  signInWithFacebook() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      // FacebookPermission.publicProfile,
      // FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken.token);
        final result =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        final email = await fb.getUserEmail();

        if (email != null) print('And your email is $email');
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        print(res.hashCode);
        break;
    }
  }
}
