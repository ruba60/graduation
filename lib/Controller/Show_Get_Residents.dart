import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Get_Residents.dart';

class ShowGetResidents {
  var serverUrl = "http://127.0.0.1:8000";

  Future<GetResident> postData() async {
    String myUrl = "$serverUrl/api/dep/get_residents";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
      'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
    }
    );
    print(jsonDecode(response.body));
    GetResident getresidents = GetResident.fromJson(jsonDecode(response.body));

    //   print(await patientInfo.);
    return getresidents;
  }}