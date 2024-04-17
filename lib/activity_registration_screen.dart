import 'package:flutter/material.dart';
import 'package:frontend/activity_list_screen.dart';
import 'package:frontend/services/activity_service.dart';

class ActivityRegistrationScreen extends StatelessWidget {
  final ActivityService activityService = ActivityService();

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Aviso"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String nome = '';
    String descricao = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Atividade'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) => nome = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => descricao = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String? results =
                        await activityService.createActivity(nome, descricao);
                    if (results != null) {
                      _showDialog(context, results);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityListScreen(),
                        ),
                      );
                    } else {
                      _showDialog(context, 'Erro ao cadastrar atividade');
                    }
                  } catch (e) {
                    _showDialog(context, 'Erro ao cadastrar atividade');
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
