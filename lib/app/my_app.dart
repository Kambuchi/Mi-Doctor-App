import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import './ui/routes/app_routes.dart';
import './ui/routes/routes.dart';
import './ui/global_controllers/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      final theme = watch(themeProvider);
      return MaterialApp(
        title: 'Mi Doctor',
        navigatorKey: router.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.SPLASH,
        darkTheme: theme.darkTheme,
        theme: theme.lightTheme,
        themeMode: theme.mode,
        navigatorObservers: [
          router.observer,
        ],
        routes: appRoutes,
      );
    });
  }
}
