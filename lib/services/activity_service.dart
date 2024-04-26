import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'dart:convert';

class Activity {
  final int id;
  final String nome;
  final String descricao;
  final String date_limit;

  Activity(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.date_limit});
}

class ActivityCreate {
  final String nome;
  final String descricao;
  final String date_limit;

  ActivityCreate(
      {required this.nome, required this.descricao, required this.date_limit});
}

class ActivityService {
  Future<String?> createActivity(ActivityCreate activityCreate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    var body = {
      'nome': activityCreate.nome,
      'descricao': activityCreate.descricao,
      'date_limit': activityCreate.date_limit
    };

    try {
      final response = await http.post(Uri.parse('${Config.baseUrl}/activity'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));

      if (response.statusCode == 201) {
        return ('Atividade criada com sucesso');
      } else {
        print(
            'Falha ao criar Atividade: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro ao criar Atividade: $e');
      return null;
    }
  }

  Future<List<Activity>> getActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse('${Config.baseUrl}/activity'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Activity> activities = [];
        for (var item in data) {
          activities.add(Activity(
              id: item['id'],
              nome: item['nome'] != null ? item['nome'] : '',
              descricao: item['descricao'] != null ? item['descricao'] : '',
              date_limit:
                  item['date_limit'] != null ? item['date_limit'] : ''));
        }
        return activities;
      } else {
        print(
            'Falha ao obter atividades: ${response.statusCode} ${response.body}');
        throw Exception('Failed to load activities');
      }
    } catch (e) {
      print('Erro ao obter atividades: $e');
      throw Exception('Failed to load activities');
    }
  }

  Future<String?> deleteActivity(int activityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    try {
      final response = await http.delete(
        Uri.parse('${Config.baseUrl}/activity/${activityId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return ('Atividade deletada com sucesso');
      } else {
        print(
            'Falha ao deletar Atividade: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro ao deletar Atividade: $e');
      return null;
    }
  }
}
