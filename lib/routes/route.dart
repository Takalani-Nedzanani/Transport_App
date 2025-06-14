import 'package:flutter/material.dart';
import 'package:transport_app/pages/admin/admin_Home_Dashboard.dart';
import 'package:transport_app/pages/Auth_Pages/forgot_Pass.dart';
import 'package:transport_app/pages/user/home_page.dart';
import 'package:transport_app/pages/Auth_Pages/landing_page.dart';
import 'package:transport_app/pages/Auth_Pages/login.dart';
import 'package:transport_app/pages/Auth_Pages/register.dart';

class RouteManager {
  static const String welcomePage = '/';
  static const String registerPage = 'registerPage';
  static const String loginPage = '/loginPage';
  static const String forgotPage = '/forgotPage';
  static const String homePage = '/homePage';
  static const String adminPage = '/adminDashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(
          builder: (context) => LandingPage(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const Registration(),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );

      case forgotPage:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );

        case adminPage:
        return MaterialPageRoute(
          builder: (context) =>  AdminDashboard(),
        );

      default:
        throw const FormatException('Route not found check routes again');
    }
  }
}
