import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/storekeepermodel.dart';

class ShowStoreKeeper {
  var serverUrl = "http://127.0.0.1:8000";

  Future<List<Storekeeper>> getData() async {
    String myUrl = "$serverUrl/api/resources/all";

    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6OSwibmFtZSI6Ik1lZGljaW5lU3RvcmVLZWVwZXIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    });
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Storekeeper.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch death data');
    }
  }
}
