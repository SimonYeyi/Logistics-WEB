import 'package:flutter/material.dart';
import 'package:logistics/comm/logistic_dio.dart';
import 'package:logistics/manage/account/login/login_page.dart';
import 'package:logistics/manage/manage_page.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    handleUnauthorized(context);
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "home": (context) => ManagePage(),
      },
      theme: ThemeData(dividerTheme: DividerThemeData(space: 1)),
    );
  }

  void handleUnauthorized(BuildContext context) {
    onUnauthorized = () {
      Toast.show("登录失效，请重新登录！", context);
      Navigator.of(context).pop();
    };
  }
}
