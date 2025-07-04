import 'package:flutter/material.dart';
import 'package:airline_system/screens/auth/login_screen.dart';
import 'package:airline_system/screens/auth/register_screen.dart';
import 'package:airline_system/screens/passenger/home_screen.dart';

// Import all other screens

Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/home': (context) => HomeScreen()
  // Add all other screens here
};
