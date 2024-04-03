import 'package:flutter/material.dart';
import 'package:frontend/user_registration_screen.dart';
import 'package:frontend/activity_registration_screen.dart';
import 'package:frontend/delivery_registration_screen.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de cadastro de usuário
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserRegistrationScreen()),
                );
              },
              child: Text('Cadastro de Usuário'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de cadastro de atividade
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityRegistrationScreen()),
                );
              },
              child: Text('Cadastro de Atividade'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de cadastro de entrega
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryRegistrationScreen()),
                );
              },
              child: Text('Cadastro de Entrega'),
            ),
          ],
        ),
      ),
    );
  }
}
