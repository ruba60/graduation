import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/all_department.dart';

class ShowAllDepartment {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<AllDepartment>> getData() async {
    String myUrl = "$serverUrl/api/dep/all";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    });
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AllDepartment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch patient data');
    }
  }
}
