import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/pationts_staying.dart';


// ignore: camel_case_types
class showpataints_staying {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<Resedent_pationt>> postData() async {
    String myUrl = "$serverUrl/api/dep/get_residents";
    // ignore: prefer_typing_uninitialized_variables
    var request;
    request.fields.addAll({'department_id': '15'});
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MTUsIm5hbWUiOiJcdTA2NDJcdTA2MzNcdTA2NDUgXHUwNjI3XHUwNjQ0XHUwNjQyXHUwNjQ0XHUwNjI4XHUwNjRhXHUwNjI5IiwiY3JlYXRlZF9hdCI6IjIwMjQtMDYtMjVUMDc6NTg6NTcuMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDI0LTA2LTI1VDA3OjU4OjU3LjAwMDAwMFoifQ=='
    });
    // ignore: avoid_print
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Resedent_pationt.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch  data');
    }
  }
}
