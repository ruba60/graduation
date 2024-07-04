import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> uploadPatientFile() async {
  var headers = {
    'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
    'token':
        'eyJpZCI6NSwibmFtZSI6IlJhZGlvR3JhcGhlciIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0=',
  };

  var request = http.MultipartRequest(
      'POST', Uri.parse('http://127.0.0.1:8000/api/patient/file'));
  request.fields.addAll({
    'patient_id': '16',
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
