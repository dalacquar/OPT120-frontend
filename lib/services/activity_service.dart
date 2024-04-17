import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'dart:convert';

class ActivityService {
  Future<String?> createActivity(String nome, String descricao) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    var body = {
      'nome': nome,
      'descricao': descricao,
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

  Future<List<Map<String, String>>> getActivities() async {
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
        List<Map<String, String>> activities = [];
        for (var item in data) {
          activities.add({
            'nome': item['nome'],
            'descricao': item['descricao'],
          });
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
}
