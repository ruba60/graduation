import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPatientController {
  Future<void> add(
      String full_name,
      String address,
      DateTime date_of_birth,
      String mom_name,
      String chain,
      String gender,
      String treatment_required,
      String case_description) async {
    String url = 'http://127.0.0.1:8000/api/patient/add';
    String token =
        'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0=';
    Map<String, String> headers = {
   //   'Content-Type': 'application/json',
      'token': token,
    };

    Map<String, dynamic> requestBody = {
      "full_name": full_name,
      "address": address,
      "date_of_birth": date_of_birth,
      "mom_name": mom_name,
      "chain": chain,
      "gender": gender,
      "case_description": case_description,
      "treatment_required": treatment_required,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('patient info added successfully!');
      } else {
        print('Failed to add paitent. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}