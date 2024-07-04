import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/surgary_Amb_model.dart';


class ShowSurgery_Amb {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<Surgery_Amb>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String myUrl = "$serverUrl/api/surgery/emall";

    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token': token
 });
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Surgery_Amb.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch death data');
    }
  }

  Future<List<Surgery_Amb>> getAllSurgeries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse('http://127.0.0.1:8000/api/surgery/emall');
    final headers = {
      'token':
      token,
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => Surgery_Amb.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch surgeries');
    }
  }

//بعد التصحيح

  Future<void> sendHttpRequest77(int patientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/surgery/emqueue'),
      headers: {
        'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
        'token':
        token,
      },
      body: {
        'patient_id': patientId.toString(),
      },
    );

    final responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200) {
      print("200");
    } else {
      print(response.reasonPhrase);
    }
  }

  //قبل التصحيح
  // Future<void> sendHttpRequest7(int patientId) async {
  //   http.Response response = await http.post(
  //       Uri.parse('http://127.0.0.1:8000/api/surgery/emqueue'),
  //       headers: {
  //         'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
  //         'token': 'eyJpZCI6MTcsIm5hbWUiOiJFbWVyZ2VuY3kgU3VyZ2VyeSBEZXBhcnRtZW50IiwiY3JlYXRlZF9hdCI6IjIwMjQtMDYtMjlUMTQ6MDA6MDQuMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDI0LTA2LTI5VDE0OjAwOjA0LjAwMDAwMFoifQ=='
  //
  //       },body: {
  //     'patient_id' : patientId,
  //   }
  //   );
  //   final responseData = json.decode(response.body);
  //   print(responseData);
  //
  //   if (response.statusCode == 200) {
  //     print("200");
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
}
