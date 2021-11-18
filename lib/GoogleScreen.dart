import 'package:flutter/material.dart';
import 'package:myproject/Login.dart';
import 'package:myproject/authentication.dart';

class GoogleScreen extends StatefulWidget {
  String name;
  String email;
  String image;
  GoogleScreen(
      {@required this.email,
      @required this.name,
      @required this.image,
      Key key})
      : super(key: key);

  @override
  _GoogleScreenState createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  bool isSigningOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Screen"),
      ),
      body: info(),
    );
  }

  info() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(widget.name),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(widget.email),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isSigningOut = true;
              });
              await Authentication.signOut(context: context);
              setState(() {
                isSigningOut = false;
              });
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text("singout"),
          ),
        ],
      ),
    );
  }
}
