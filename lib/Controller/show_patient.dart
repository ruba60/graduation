import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/Add_Patient.dart';

class ShowPatient {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<AddPatient>> getData() async {
    String myUrl = "$serverUrl/api/patient/allempatient";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          token,
    });
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AddPatient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch patient data');
    }
  }
}
