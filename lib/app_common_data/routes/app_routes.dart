import 'package:flutter/material.dart';
import 'package:pbl5/screens/login_screen/login_screen.dart';
import 'package:pbl5/screens/register_screen/register_screen.dart';

import '/screens/main_screen/main_screen.dart';

class Routes {
  static String mainScreen = '/main-screen';
  static String loginScreen = '/login-screen';
  static String registerScreen = '/register-screen';

  static final Map<String, Widget Function(BuildContext context)> routes = {
    mainScreen: (context) => const MainScreen(),
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
  };
}
