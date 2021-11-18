import 'package:flutter/material.dart';
import 'package:myproject/googlemap/MapScreen.dart';

class Googlemap extends StatefulWidget {
  const Googlemap({Key key}) : super(key: key);

  @override
  _GooglemapState createState() => _GooglemapState();
}

class _GooglemapState extends State<Googlemap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google map"),
      ),
      body: info(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MapScreen()));
        },
        child: const Icon(Icons.pin_drop_outlined),
        backgroundColor: Colors.blue,
      ),
    );
  }

  info() {
    return Center(
      child: Container(
        child: Text("Google map"),
      ),
    );
  }
}
