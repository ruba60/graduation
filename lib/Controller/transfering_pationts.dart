import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/Transfer_patints.dart';


// ignore: camel_case_types
class transferpationts {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<Pationt_Tr>> postData() async {
    String myUrl = "$serverUrl/api/dep/emptrlist";
    // ignore: prefer_typing_uninitialized_variables

    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MTMsIm5hbWUiOiJcdTA2NDJcdTA2MzNcdTA2NDUgXHUwNjI3XHUwNjQ0XHUwNjIzXHUwNjM3XHUwNjQxXHUwNjI3XHUwNjQ0IiwiY3JlYXRlZF9hdCI6IjIwMjQtMDYtMjVUMDc6NTg6MTYuMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDI0LTA2LTI1VDA3OjU4OjE2LjAwMDAwMFoifQ=='
    });
    // ignore: avoid_print
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Pationt_Tr.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch death data');
    }
  }
}
