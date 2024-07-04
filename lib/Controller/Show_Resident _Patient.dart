import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Models/Resident_Patient.dart';
import '../Models/patient.dart';

class ShowResidentPatient {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<ResidentPatientModel>> getData() async {
    String myUrl = "$serverUrl/api/dep/get_residents";

    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token': 'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
  });
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => ResidentPatientModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch patient data');
    }
  }
}
