import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_navigator.dart';
import 'package:flutter_boost/flutter_boost_app.dart';
import 'package:logistics/comm/logistic_dio.dart';
import 'package:logistics/manage/account/login/login_page.dart';
import 'package:logistics/manage/manage_page.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final Map<String, FlutterBoostRouteFactory> routerMap = {
    '/': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => LoginPage());
    },
    'home': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => ManagePage());
    },
  };

  Route<dynamic>? routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name];
    return func?.call(settings, uniqueId);
  }

  @override
  Widget build(BuildContext context) {
    handleUnauthorized(context);
    return FlutterBoostApp(routeFactory, appBuilder: (home) {
      return MaterialApp(
        home: home,
        theme: ThemeData(dividerTheme: DividerThemeData(space: 1)),
      );
    });
  }

  void handleUnauthorized(BuildContext context) {
    onUnauthorized = () {
      Toast.show("登录失效，请重新登录！", context);
      BoostNavigator.of().pop();
    };
  }
}
