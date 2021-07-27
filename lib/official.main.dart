import 'package:flutter/material.dart';
import 'package:logistics/home/home_page.dart';
import 'package:logistics/track/track_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "track": (context) => TrackPage(),
      },
      theme: ThemeData(
        platform: TargetPlatform.android,
        dividerTheme: DividerThemeData(space: 1),
      ),
    );
  }
}
