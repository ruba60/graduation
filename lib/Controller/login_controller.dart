import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginController {


  Future<String> performLogin(String departmentId, String password) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/login');
    final headers = {
      'sessionKey': 'IjY2M2E1ZjRkMjMzZjAi',
    };
    final body = {
      'department_id': departmentId,
      'password': password,
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final token = jsonData['token'];
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }
}