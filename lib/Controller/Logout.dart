import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogOut {
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Token = prefs.getString('token');

      final response =
          await http.post(Uri.parse('http://$serverUrl /api/logout'), headers: {
        'Content-Type': 'application/json',
        'token':
            'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
      });

      if (response.statusCode == 200) {
        // في حالة النجاح، قم بحذف رمز الوصول المخزن محليًا
        await prefs.remove('access_token');
        print('Logout successful');
      } else {
        print('Logout failed: ${response.body}');
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
