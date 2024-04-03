import 'package:flutter/material.dart';

class DeliveryRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Entrega'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuário'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Atividade'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
