import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost_app.dart';
import 'package:logistics/home/home_page.dart';
import 'package:logistics/track/track_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final Map<String, FlutterBoostRouteFactory> routerMap = {
    '/': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => HomePage());
    },
    'track': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => TrackPage());
    },
  };

  Route<dynamic>? routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name];
    return func?.call(settings, uniqueId);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory, appBuilder: (home) {
      return MaterialApp(
        home: home,
        theme: ThemeData(
          platform: TargetPlatform.android,
          dividerTheme: DividerThemeData(space: 1),
        ),
      );
    });
  }
}
