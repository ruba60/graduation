import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../../Models/pationtStaying.dart';

class ResidentPatient extends StatefulWidget {
  const ResidentPatient({Key? key}) : super(key: key);

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<ResidentPatient> {
  late Future<PatientInfo> pationtData;

  @override
  void initState() {
    super.initState();
    pationtData = fetchEmployeeData();
  }

  Future<
      PatientInfo> fetchEmployeeData() async {
    var headers = {
      'token':
          'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/patient/file'));
    //request.fields.addAll({'emp_id': '2'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      // Process the response body here
      print(responseBody);
      // Convert the response body to Map<String, dynamic>
      Map<String, dynamic> json = jsonDecode(responseBody);
      // Assuming the JSON response is in the format of the Employees model
      PatientInfo pationt = PatientInfo.fromJson(json);
      return pationt;
    } else {
      print(response.reasonPhrase);
      throw Exception('Failed to fetch employee data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الموظفين'),
      ),
      body: Center(
        child: FutureBuilder<PatientInfo>(
          future: pationtData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('حدث خطأ أثناء جلب بيانات الموظف');
            } else if (snapshot.hasData) {
              PatientInfo pationt = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('اسم : ${pationt.name}'),
                  // Text('اسم : ${pationt.departmentId}'),
                  // // Text('رقم الموظف: ${pationt.id}'),
                  // Text('رقم القسم: ${pationt.updatedAt}'),
                  // Text('اسم : ${pationt.id}'),
                  // // Text('تاريخ الإنشاء: ${employee.createdAt}'),
                  // // Text('تاريخ التحديث: ${employee.updatedAt}'),
                ],
              );
            } else {
              return Text('لا توجد بيانات لعرضها');
            }
          },
        ),
      ),
    );
  }
}
