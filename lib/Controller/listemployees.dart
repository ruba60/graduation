import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/List_Emp.dart';


// ignore: camel_case_types
class list_emps {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<List_Emp>> getData() async {
    String myUrl = "$serverUrl/api/HR/allemp";
    // ignore: prefer_typing_uninitialized_variables

    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MTEsIm5hbWUiOiJIUiIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIxLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMS4wMDAwMDBaIn0='
    });
    // ignore: avoid_print
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => List_Emp.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch death data');
    }
  }
}
