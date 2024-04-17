import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'config.dart';

class AuthService {
  static Future<String?> authLogin(String email, String password) async {
    var body = {
      'email': email,
      'password': password,
    };
    try {
      final response =
          await http.post(Uri.parse('${Config.baseUrl}/auth/login'),
              headers: <String, String>{
                'Content-Type':
                    'application/json; charset=UTF-8', // Defina o cabeçalho Content-Type
              }, // Use a base URL da classe Config
              body: jsonEncode(body));

      if (response.statusCode == 200) {
        print('entrou aq');
        // Se a requisição for bem-sucedida, retorna o token
        final responseData = json.decode(response.body);
        print(responseData);
        final String token = responseData['token'];
        print(token);
        // Armazenar o token localmente utilizando o SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setBool('isLoggedIn', true);

        print("saiu");
        return token;
      } else {
        // Se a requisição falhar, retorna null
        return null;
      }
    } catch (e) {
      // Em caso de erro, retorna null
      print('Erro ao realizar login: $e');
      return null;
    }
  }
}
