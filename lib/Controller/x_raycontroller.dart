import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/x_raymodel.dart';



class ShowXray {
  var serverUrl = "http://127.0.0.1:8000";

  // بعد التصحيح
  Future<void> sendHttpRequest(int patientId) async {
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/xray/xpatient'),
      headers: {
        'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
        'token':
        'eyJpZCI6NSwibmFtZSI6IlJhZGlvR3JhcGhlciIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0=',
      },
      body: {
        'patient_id': patientId.toString(), // تحويل قيمة patientId إلى نص
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
  // Future<void> sendHttpRequest(int patientId) async {
  //   http.Response response = await http.post(
  //     Uri.parse('http://127.0.0.1:8000/api/xray/xpatient'),
  //     headers: {
  //       'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
  //       'token':
  //       'eyJpZCI6NSwibmFtZSI6IlJhZGlvR3JhcGhlciIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
  //
  //     },body: {
  //       'patient_id' : patientId,
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


  Future<List<X_ray>?> fetchData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/xray/all');
    final headers = {
      'sessionKey': '',
      'token':
          'eyJpZCI6NSwibmFtZSI6IlJhZGlvR3JhcGhlciIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      return responseData.map((json) => X_ray.fromJson(json)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
