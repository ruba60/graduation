import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/AllDeaths.dart';



class ShowAllDeaths {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<AllDeaths>> getData() async {
    String myUrl = "$serverUrl/api/deaths/all";

    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token': 'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjpudWxsLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yMVQxOTozOToxMS4wMDAwMDBaIn0='});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AllDeaths.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch death data');
    }
  }
}
