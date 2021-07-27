import 'package:flutter/material.dart';
import 'package:logistics/manage/account/login/login_page.dart';
import 'package:logistics/manage/manage_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => ManagePage(),
        "login": (context) => LoginPage(),
      },
      theme: ThemeData(dividerTheme: DividerThemeData(space: 1)),
    );
  }
}
