import 'package:flutter/material.dart';
import 'package:frontend/main_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/user_service.dart';
import 'user_registration_screen.dart'; // Importe a tela de registro

class UserLoginScreen extends StatelessWidget {
  final UserService userService = UserService();

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Aviso"),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login de Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Chama a função de login e espera pela resposta
                  String? loggedIn =
                      await AuthService.authLogin(email, password);

                  print(loggedIn);

                  // Verifica se o login foi bem-sucedido
                  if (loggedIn != null) {
                    _showDialog(context, 'Login realizado com sucesso');
                    // Navegar para a tela principal (MainScreen)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MainScreen(), // Substitua MainScreen pelo nome da sua tela principal
                      ),
                    );
                  } else {
                    _showDialog(
                        context, 'Falha no login. Verifique suas credenciais.');
                  }
                } catch (e) {
                  _showDialog(context, 'Ocorreu um erro durante o login: $e');
                }
              },
              child: Text('Login'),
            ),

            SizedBox(height: 10),
            // Link para a tela de registro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserRegistrationScreen(),
                  ),
                );
              },
              child: Text("Não tem conta ainda? Cadastre-se"),
            ),
          ],
        ),
      ),
    );
  }
}
