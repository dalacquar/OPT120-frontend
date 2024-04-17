import 'package:flutter/material.dart';
import 'package:frontend/auth_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_login_screen.dart'; // Importe a tela de login
import 'main_screen.dart'; // Importe a tela principal

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garanta que os widgets estejam inicializados
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? MainScreen() : UserLoginScreen(),
    );
  }
}
