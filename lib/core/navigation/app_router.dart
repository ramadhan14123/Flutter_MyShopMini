import 'package:flutter/material.dart';
import '../../screens/welcome_screen.dart';
import '../../screens/home_screen.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const home = '/home';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return _fade( const WelcomeScreen(), settings);
      case AppRoutes.home:
        return _fade( const HomeScreen(), settings);
      default:
        return _fade( const WelcomeScreen(), settings);
    }
  }

  static PageRoute _fade(Widget child, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, widget) {
        return FadeTransition(opacity: animation, child: widget);
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }
}