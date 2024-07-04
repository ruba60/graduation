import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/pationts_staying.dart';


class ResidantE {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<Resedent_pationt>> postData({bool shouldprint = false}) async {
    String myUrl = "$serverUrl/api/dep/get_residents";

    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MTIsIm5hbWUiOiJFeWVzIERlcGFydG1lbnQiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNi0yNVQwNzo1NzozMy4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDYtMjVUMDc6NTc6MzMuMDAwMDAwWiJ9'
    });
    // print(jsonDecode(response.body));
    if (shouldprint) {
      print('ssssssssssssss ${response.body}');
      print('sssssssssssss ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      try {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Resedent_pationt.fromJson(json)).toList();
      } catch (e) {
        print('the exception is: $e');

        throw Exception('Failed to fetch death data');
      }
    } else {
      throw Exception('Failed to fetch death data');
    }
  }

// void postDatatodelet(int id) async {
//   var url = 'http://127.0.0.1:8000/api/emtest/emspatient/${id}';
//   var headers = {
//     'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
//     'token':
//     'eyJpZCI6NiwibmFtZSI6IkVtZXJnZW5jeVRlc3RMYWIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
//   };
//
//   var request = http.MultipartRequest('POST', Uri.parse(url));
//   request.headers.addAll(headers);
//
//   request.fields['patient_id'] = '5';
//
//   try {
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       // Handle the successful response here
//       var responseStream = await response.stream.bytesToString();
//       print(responseStream);
//     } else {
//       // Handle any error response here
//       print('Request failed with status: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle any exceptions here
//     print('Exception: $e');
//   }
// }
}
