import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/activity_list_screen.dart';
import 'package:frontend/services/activity_service.dart';

class ActivityRegistrationScreen extends StatefulWidget {
  @override
  _ActivityRegistrationScreenState createState() =>
      _ActivityRegistrationScreenState();
}

class _ActivityRegistrationScreenState extends State {
  final ActivityService activityService = ActivityService();
  late List<Activity> _activities = [];

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

  TextEditingController _dateLimitController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                onChanged: (value) => setState(() {
                  _nomeController.text = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => setState(() {
                  _descricaoController.text = value;
                }),
              ),
              TextField(
                  controller: _dateLimitController,
                  decoration: InputDecoration(labelText: 'Data Limite'),
                  readOnly: true,
                  onTap: () => _selectDate(context)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var activityAdd = ActivityCreate(
                      nome: _nomeController.text,
                      descricao: _descricaoController.text,
                      date_limit: _dateLimitController.text);
                  try {
                    String? results =
                        await activityService.createActivity(activityAdd);
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

  Future<void> _selectDate(context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _dateLimitController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
