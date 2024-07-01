import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Patients_staying_in_the_department_co.dart';
import '../../Models/Resident_Patient.dart';
import '../../Models/children.dart';


class AdmittedPatientsPage extends StatefulWidget {
  // ignore: use_super_parameters
  const AdmittedPatientsPage({Key? key}) : super(key: key);

  @override
  State<AdmittedPatientsPage> createState() => _AdmittedPatientsPageState();
}

class _AdmittedPatientsPageState extends State<AdmittedPatientsPage> {
  List<Children> children = [];
  showpataints_staying showpatientstaying = showpataints_staying();
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> fetchData() async {
    String myUrl = "$serverUrl/api/dep/get_residents";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MTMsIm5hbWUiOiJcdTA2NDJcdTA2MzNcdTA2NDUgXHUwNjI3XHUwNjQ0XHUwNjIzXHUwNjM3XHUwNjQxXHUwNjI3XHUwNjQ0IiwiY3JlYXRlZF9hdCI6IjIwMjQtMDYtMjVUMDc6NTg6MTYuMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDI0LTA2LTI1VDA3OjU4OjE2LjAwMDAwMFoifQ=='
    });
    final responseData = json.decode(response.body);
    setState(() {
      children = (responseData as List)
          .map((json) => Children.fromJson(json))
          .toList();
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          final patientstaying = children[index];
          return Container(
            color: index.isEven ? Colors.white : Colors.grey[300],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " ${patientstaying.residentPatient}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                   onPressed: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ResidentPatient(),
                  //     ),
                  //   );
                  },
                  // ignore: prefer_const_constructors
                  child: Text('عرض تفاصيل المريض'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
