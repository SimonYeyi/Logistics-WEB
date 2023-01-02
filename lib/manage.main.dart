import 'package:flutter/material.dart';
import 'package:logistics/comm/account_dao.dart';
import 'package:logistics/comm/scroll_behavior.dart';
import 'package:logistics/manage/account/login/login_page.dart';
import 'package:logistics/manage/manage_page.dart';
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
        initialRoute: "splash",
        routes: {
          "/": (context) => ManagePage(),
          "login": (context) => LoginPage(),
          "splash": (context) => SplashPage(),
        },
        theme: ThemeData(dividerTheme: DividerThemeData(space: 1)),
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountDao().find().then((accountDTO) {
      if (accountDTO == null) {
        Navigator.of(context).pushReplacementNamed("login");
      } else {
        Navigator.of(context).pushReplacementNamed("/");
      }
    });
    return Container();
  }
}