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
      body: Container(
        color: Colors.grey[900], // Fundo cinza escuro mais escuro
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linha dividindo o título da tela e o menu
            Container(
              height: 1,
              color: Colors.white,
            ),
            // Menu de navegação
            Container(
              padding:
                  EdgeInsets.all(15), // Padding de 15 pixels em todos os lados
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.white,
                      width: 1.0), // Bordar na parte inferior
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela de cadastro de usuário
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRegistrationScreen()),
                      );
                    },
                    child: Text('Cadastro de Usuário'),
                  ),
                  SizedBox(width: 10), // Espaçamento entre os botões
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela de cadastro de atividade
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivityRegistrationScreen()),
                      );
                    },
                    child: Text('Cadastro de Atividade'),
                  ),
                  SizedBox(width: 10), // Espaçamento entre os botões
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela de cadastro de entrega
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
            // Outros widgets do corpo aqui
          ],
        ),
      ),
    );
  }
}
