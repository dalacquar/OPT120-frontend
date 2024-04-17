import 'package:flutter/material.dart';
import 'package:frontend/activity_list_screen.dart';
import 'package:frontend/user_registration_screen.dart';
import 'package:frontend/activity_registration_screen.dart';
import 'package:frontend/delivery_registration_screen.dart';
import 'package:frontend/auth_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Método para fazer logout
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove o token do SharedPreferences
    await prefs.setBool('isLoggedIn', false); // Define isLoggedIn como false
    // Navega de volta para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Principal'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1,
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivityListScreen()),
                      );
                    },
                    child: Text('Listagem de Atividade'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryRegistrationScreen()),
                      );
                    },
                    child: Text('Cadastro de Entrega'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
