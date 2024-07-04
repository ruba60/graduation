import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/surgery_model.dart';



class ShowSurgery{
  var serverUrl = "http://127.0.0.1:8000";



  Future<List<Surgery_model>> getAllSurgeries() async {
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
      print(jsonData);
      return jsonData.map((data) => Surgery_model.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch surgeries');
    }
  }






  // مصحح
  Future<void> sendHttpRequest66(int patientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/surgery/queue'),
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
  // Future<void> sendHttpRequest6(int patientId) async {
  //   http.Response response = await http.post(
  //       Uri.parse('http://127.0.0.1:8000/api/surgery/queue'),
  //       headers: {
  //         'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
  //         'token': 'eyJpZCI6MTYsIm5hbWUiOiJzdXJnZXJ5IGRlcGFydG1lbnQgKFx1MDY0Mlx1MDYzM1x1MDY0NSBcdTA2MjdcdTA2NDRcdTA2MzlcdTA2NDVcdTA2NDRcdTA2NGFcdTA2MjdcdTA2MmEpIiwiY3JlYXRlZF9hdCI6IjIwMjQtMDYtMjZUMjA6NDU6MTEuMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDI0LTA2LTI2VDIwOjQ1OjExLjAwMDAwMFoifQ=='
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
