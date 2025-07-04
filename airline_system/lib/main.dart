import 'package:flutter/material.dart';
import 'package:airline_system/utils/routes.dart';
import 'package:airline_system/utils/auth_helper.dart';
import 'package:airline_system/screens/passenger/home_screen.dart';
import 'package:airline_system/screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await AuthHelper.getToken();

runApp(MyApp(token: token ?? ''));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Airline System',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: token != null ? '/home' : '/login',
      routes: appRoutes,
    );
  }
}
