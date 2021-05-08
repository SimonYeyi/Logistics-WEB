import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_navigator.dart';

class ManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ManagePageState();
  }
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            BoostNavigator.of().push("track");
          },
          child: Text("My manage Page"),
        ),
      ),
    );
  }
}
