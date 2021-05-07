import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_navigator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            BoostNavigator.of().push("track");
          },
          child: Text("My Home Page"),
        ),
      ),
    );
  }
}
