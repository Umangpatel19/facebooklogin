import 'package:flutter/material.dart';
import 'package:myproject/FacebookScreen.dart';
import 'package:myproject/authentication.dart';

class FacebookLogin extends StatefulWidget {
  const FacebookLogin({Key key}) : super(key: key);

  @override
  _FacebookLoginState createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("facebook Login"),
      ),
      body: info(),
    );
  }

  info() {
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
          Container(
            child: ElevatedButton(
              child: Text("facebook Login"),
              onPressed: () async {
                await Authentication().signInWithFacebook();

                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => page(),
                //   ),
                // );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FacebookScreen()));

                print("object");
                //print("object");
              },
            ),
          ),
        ],
      ),
    );
  }
}
