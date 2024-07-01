
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/testlabAmb_model.dart';


class ShowTestlab_Amb {


  Future<List<TestLab_Amb>> getAllTestLabAmb() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/emtest/all'),
        headers: {
          'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
          'token': 'eyJpZCI6NiwibmFtZSI6IkVtZXJnZW5jeVRlc3RMYWIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9',
        });

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => TestLab_Amb.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch test labs');
    }
  }


  //مصحح


  Future<void> sendHttpRequest55(int patientId) async {
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/emtest/emspatient'),
      headers: {
        'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
        'token':
        'eyJpZCI6NiwibmFtZSI6IkVtZXJnZW5jeVRlc3RMYWIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9',
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
//   Future<void> sendHttpRequest5(int patientId) async {
//     http.Response response = await http.post(
//         Uri.parse('http://127.0.0.1:8000/api/emtest/emspatient'),
//         headers: {
//           'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
//           'token': 'eyJpZCI6NiwibmFtZSI6IkVtZXJnZW5jeVRlc3RMYWIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
//
//         },body: {
//       'patient_id' : patientId,
//     }
//     );
//     final responseData = json.decode(response.body);
//     print(responseData);
//
//     if (response.statusCode == 200) {
//       print("200");
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

}














