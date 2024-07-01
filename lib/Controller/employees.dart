import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/pationtStaying.dart';


class emp {
  Future<PatientInfo> fetchEmployeeData() async {
    var headers = {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MTEsIm5hbWUiOiJIUiIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIxLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMS4wMDAwMDBaIn0='
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/HR/showemp'));
    request.fields.addAll({'emp_id': '1'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var jsonData = json.decode(responseBody);
      return PatientInfo.fromJson(jsonData);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
