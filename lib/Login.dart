import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/GoogleScreen.dart';
import 'package:myproject/authentication.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Login Page"),
      ),
      body: displ(),
    );
  }

  displ() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          TextFormField(
            initialValue: '',
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            initialValue: '',
            decoration: InputDecoration(
              labelText: 'Password ',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: Text("login"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoogleScreen(
                    name: _user.displayName,
                    email: _user.email,
                    image: _user.photoURL,
                  ),
                ),
              );
              print("object");
            },
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {});
              User user =
                  await Authentication.signInWithGoogle(context: context);

              setState(() {});
              if (user != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => GoogleScreen(
                      email: user.email,
                      name: user.displayName,
                      image: user.photoURL,
                    ),
                  ),
                );
              }
              print("object");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFFFF8C00)),
            ),
            child: Text("Google signin"),
          ),
        ],
      ),
    );
  }
}
