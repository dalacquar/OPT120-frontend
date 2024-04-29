import 'package:flutter/material.dart';
import 'package:frontend/activity_list_screen.dart';
import 'package:frontend/services/activity_service.dart';

class ActivityEditScreen extends StatefulWidget {
  final Activity activity;

  ActivityEditScreen({required this.activity});

  @override
  _ActivityEditScreenState createState() => _ActivityEditScreenState();
}

class _ActivityEditScreenState extends State<ActivityEditScreen> {
  final ActivityService activityService = ActivityService();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _dateLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preencha os controladores de texto com os dados da atividade recebida
    _nomeController.text = widget.activity.nome ?? '';
    _descricaoController.text = widget.activity.descricao ?? '';
    _dateLimitController.text = widget.activity.date_limit ?? '';
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Atividade'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: _dateLimitController,
                decoration: InputDecoration(labelText: 'Data Limite'),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  widget.activity.nome = _nomeController.text;
                  widget.activity.descricao = _descricaoController.text;
                  widget.activity.date_limit = _dateLimitController.text;
                  try {
                    String? results =
                        await activityService.updateActivity(widget.activity);
                    if (results != null) {
                      _showDialog(context, results);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityListScreen(),
                        ),
                      );
                    } else {
                      _showDialog(context, 'Erro ao editar atividade');
                    }
                  } catch (e) {
                    _showDialog(context, 'Erro ao editar atividade');
                  }
                },
                child: Text('Salvar'),
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
