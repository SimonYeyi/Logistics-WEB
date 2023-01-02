import 'package:flutter/material.dart';
import 'package:logistics/comm/scroll_behavior.dart';
import 'package:logistics/home/home_page.dart';
import 'package:logistics/track/track_page.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      duration: Duration(seconds: 5),
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => HomePage(),
          "track": (context) => TrackPage(),
        },
        theme: ThemeData(
          dividerTheme: DividerThemeData(space: 1),
        ),
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}
