import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/testlabmodel.dart';


class ShowTestlab {
  var serverUrl = "http://127.0.0.1:8000";


  //مصحح

  Future<void> sendHttpRequest22(int patientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/test/spatient'),
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
  // Future<void> sendHttpRequest2(int patientId) async {
  //   http.Response response = await http.post(
  //       Uri.parse('http://127.0.0.1:8000/api/test/spatient'),
  //       headers: {
  //         'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
  //         'token': 'eyJpZCI6NywibmFtZSI6IlRlc3RMYWIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
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

  Future<List<TestLab>?> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse('http://127.0.0.1:8000/api/xray/all');
    final headers = {
      'sessionKey': '',
      'token': token
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      return responseData.map((json) => TestLab.fromJson(json)).toList();

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<List<TestLab>> getAllTests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse('http://127.0.0.1:8000/api/test/all');
    final headers = {
      'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
      'token': token,
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => TestLab.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch tests');
    }
  }
}
