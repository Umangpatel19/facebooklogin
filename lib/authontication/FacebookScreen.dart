import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FacebookScreen extends StatefulWidget {
  const FacebookScreen({Key key}) : super(key: key);

  @override
  _FacebookScreenState createState() => _FacebookScreenState();
}

class _FacebookScreenState extends State<FacebookScreen> {
  bool isSigningOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Succsess Login"),
      ),
      body: disp(),
    );
  }

  disp() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:
                      NetworkImage(FirebaseAuth.instance.currentUser.photoURL),
                  fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(FirebaseAuth.instance.currentUser.displayName),
          SizedBox(
            height: 30,
          ),
          Text(FirebaseAuth.instance.currentUser.uid),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
