import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/xray_amb_model.dart';

class ShowXray_Amb {
  var serverUrl = "http://127.0.0.1:8000";

 //بعد التصحيح

  Future<void> sendHttpRequest11(int patientId) async {
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/emxray/xpatient'),
      headers: {
        'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
        'token':
        'eyJpZCI6NCwibmFtZSI6IkVtZXJnZW5jeVJhZGlvR3JhcGhlciIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0=',
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




  // Future<void> sendHttpRequest1(int patientId) async {
  //   http.Response response = await http.post(
  //       Uri.parse('http://127.0.0.1:8000//api/emxray/xpatient'),
  //       headers: {
  //         'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
  //         'token':'eyJpZCI6NCwibmFtZSI6IkVtZXJnZW5jeVJhZGlvR3JhcGhlciIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
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

  Future<List<x_ray_Amb>?> fetchData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/xray/all');
    final headers = {
      'sessionKey': '',
      'token': 'eyJpZCI6NCwibmFtZSI6IkVtZXJnZW5jeVJhZGlvR3JhcGhlciIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      return responseData.map((json) => x_ray_Amb.fromJson(json)).toList();

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


}
