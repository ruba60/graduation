import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../Models/PatientFile.dart';
import '../../Models/Patient_File.dart';

class ResidentPatient extends StatefulWidget {
  final int id;
  ResidentPatient(this.id);
  @override
  _patientScreenState createState() => _patientScreenState();
}

class _patientScreenState extends State<ResidentPatient> {
  late Future<PatientFile> patientData;

  @override
  void initState() {
    super.initState();
    patientData = fetchPatientData1();
  }

  Future<PatientFile> fetchPatientData1() async {
    String myUrl = "http://127.0.0.1:8000/api/patient/file";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token': token,
    },
    body:{
      'patient_id' : '${widget.id+1}',
    });

    if (response.statusCode == 200) {
      print('${widget.id}');
      print(jsonDecode(response.body));
      final dynamic jsonData = json.decode(response.body);
      return PatientFile.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch patient data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عرض تفاصيل المريض'),
      ),
      body: Center(
        child: FutureBuilder<PatientFile>(
          future: patientData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('حدث خطأ أثناء جلب بيانات المريض');
            } else if (snapshot.hasData) {
              PatientFile patient = snapshot.data!;
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('الاسم'),
                      subtitle: Text('${patient.patientInfo!.fullName}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('العنوان'),
                      subtitle: Text('${patient.patientInfo!.address}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('القيد'),
                      subtitle: Text('${patient.patientInfo!.chain}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('الجنس'),
                      subtitle: Text('${patient.patientInfo!.gender}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('الحالة'),
                      subtitle: Text('${patient.patientInfo!.caseDescription}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('العلاج'),
                      subtitle: Text('${patient.patientInfo!.treatmentRequired}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('تاريخ الميلاد'),
                      subtitle: Text('${patient.patientInfo!.dateOfBirth}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('رقم المريض'),
                      subtitle: Text('${patient.patientInfo!.id}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('اسم الأم'),
                      subtitle: Text('${patient.patientInfo!.momName}'),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('لا توجد بيانات لعرضها');
            }
          },
        ),
      ),
    );
  }
}