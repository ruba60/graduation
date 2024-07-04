import 'dart:convert';
import 'package:http/http.dart' as http;


import '../Models/AllDeaths.dart';
import '../Models/All_Births.dart';



class ShowAllBirths {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<AllBirths>> getData() async {
    String myUrl = "$serverUrl/api/births/all";

    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token': 'eyJpZCI6OCwibmFtZSI6IkFkbWlzc2lvbk1vbml0b3IiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AllBirths.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch death data');
    }
  }
}
