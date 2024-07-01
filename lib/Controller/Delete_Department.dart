import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteDepartment {
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> deleteDep(int id) async {
    String myUrl = "$serverUrl/api/dep/delete/${id}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.delete(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    });
  }
}
