import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/children.dart';


// ignore: camel_case_types
class showpataints_staying {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<Children>> postData() async {
    String myUrl = "$serverUrl/api/dep/get_residents";
    // ignore: prefer_typing_uninitialized_variables
    var request;
    request.fields.addAll({'department_id': '13'});
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MTMsIm5hbWUiOiJcdTA2NDJcdTA2MzNcdTA2NDUgXHUwNjI3XHUwNjQ0XHUwNjIzXHUwNjM3XHUwNjQxXHUwNjI3XHUwNjQ0IiwiY3JlYXRlZF9hdCI6IjIwMjQtMDYtMjVUMDc6NTg6MTYuMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDI0LTA2LTI1VDA3OjU4OjE2LjAwMDAwMFoifQ=='
    });
    // ignore: avoid_print
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Children.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch death data');
    }
  }
}
