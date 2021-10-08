import 'package:food_dash/presentation/root/root.dart';
import 'package:food_dash/presentation/view/screen/auth/register_screen.dart';
import 'package:food_dash/presentation/view/screen/error/error_screen.dart';
import 'package:food_dash/presentation/view/screen/home/home_screen.dart';
import 'package:food_dash/presentation/view/screen/profile/profile.dart';
import 'package:food_dash/presentation/view/screen/screen.dart';
import 'package:flutter/material.dart';

/// AppRouter define the routing for the app
class AppRouter {
  static const String root = '/';
  static const String loginScreen = '/login-screen';
  static const String registerScreen = '/register-screen';
  static const String homeScreen = '/home-screen';
  static const String profileScreen = '/profile-screen';

  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => Root());
        break;
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
        break;
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
        break;
      default:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }

  void dispose() {}
}
