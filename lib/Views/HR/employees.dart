import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Models/pationtStaying.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late Future<PatientInfo> employeeData;

  @override
  void initState() {
    super.initState();
    employeeData = fetchEmployeeData();
  }

  Future<PatientInfo> fetchEmployeeData() async {
    var headers = {
      'token':
          'eyJpZCI6MTEsIm5hbWUiOiJIUiIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIxLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMS4wMDAwMDBaIn0='
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/HR/showemp'));
    request.fields.addAll({'emp_id': '1'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      // Process the response body here
      print(responseBody);
      // Convert the response body to Map<String, dynamic>
      Map<String, dynamic> json = jsonDecode(responseBody);
      // Assuming the JSON response is in the format of the Employees model
      PatientInfo employees = PatientInfo.fromJson(json);
      return employees;
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
          future: employeeData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('حدث خطأ أثناء جلب بيانات الموظف');
            } else if (snapshot.hasData) {
              PatientInfo employee = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('اسم الموظف: ${employee.name}'),
                  // Text('رقم الموظف: ${employee.id}'),
                  // Text('رقم القسم: ${employee.departmentId}'),
                  // Text('تاريخ الإنشاء: ${employee.createdAt}'),
                  // Text('تاريخ التحديث: ${employee.updatedAt}'),
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
