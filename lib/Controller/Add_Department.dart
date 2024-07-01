import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDepartmentController {
  Future<void> adddepartment(String name, String password) async {
    String url = 'http://127.0.0.1:8000/api/resources/store';
    String token =
        'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': token,
    };

    Map<String, dynamic> requestBody = {
      'name': name,
      'password': password,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Department added successfully');
      } else {
        print('Failed to add Departyment. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}