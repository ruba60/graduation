import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'AddPatient.dart';
import 'Ambulance.dart';

final List<String> _departments = [
  'اسعاف',
  'مراقب الدوام',
  'ادمن',
  'قسم الأطفال',
  'قسم الهضمية',
  'قسم العظمية',
  'قسم النسائية',
  'قسم الأشعة',
  'قسم المخابر',
  'قسم الجراحة',
  'قسم البولية',
  'قسم الصدرية',
  'قسم القلبية',
  'قسم الجلدية',
  'قسم الأعصاب',
  // Add other departments here
];


class PatientDetailsPage extends StatefulWidget {

  String? full_name;
// String? caseDescription;
// String? treatmentRequired;
  PatientDetailsPage({super.key, required this.full_name,
  });

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {


// final Patient patient;
  String? _selectedDepartment;

  //PatientDetailsPage({required this.patient});

  TextEditingController textController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var p;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        title: Text('تفاصيل المريض',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AmbulanceScreen()),
              );
            }),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child:



    Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue[100]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'الملف الطبي',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Text(
                      'الإسم الثلاثي',
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${widget.full_name}",
                        style:
                        TextStyle(fontSize: 15, color: Colors.black)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'توصيف حالة المريض',
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("caseDescription",
                        style:
                        TextStyle(fontSize: 15, color: Colors.black)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'العلاج المقترح',
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text( "treatmentRequired",
                        style:
                        TextStyle(fontSize: 15, color: Colors.black)),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPatient()));
                },
                child: Text(
                  'تعديل',
                  style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ],

        ),
      ),
    ),),


          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: Text('اختر قسم'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DropdownButton<String>(
                                    value: _selectedDepartment,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedDepartment = newValue;
                                      });
                                    },
                                    items:
                                        _departments.map((String department) {
                                      return DropdownMenuItem<String>(
                                        value: department,
                                        child: Text(department),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () async {// Construct the request
                                    var authHeaders = {
                                      'sessionKey': 'IjY2MmI2NTk3NjM4ZjIi',
                                      'token': 'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0='
                                    };

                                    var transferRequest = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/patient/transfer'));
                                    transferRequest.fields.addAll({
                                      'patient_id': '2',
                                      'tr_department': '13'
                                    });
                                    transferRequest.headers.addAll(authHeaders);

// Send the request
                                    http.StreamedResponse response = await transferRequest.send();
                                    if (response.statusCode == 200) {
                                      print(await response.stream.bytesToString());
                                    } else {
                                    print(response.reasonPhrase);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "تحويل",
                                    style: TextStyle(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    'تحويل إلى قسم',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () async {
                    var headers = {
                      'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
                      'token': 'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0=',
                    };

                    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/emrequest/xray'));
                    request.fields.addAll({
                      'patient_id': '14',
                    });

                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                    } else {
                    print(response.reasonPhrase);
                    }
                  },
                  child: Text(
                    'طلب صورة شعاعية',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    var headers = {
                      'token': 'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0=',
                    };

                    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/surgery/emadd'));
                    request.fields.addAll({
                      'patient_id': '14',
                    });

                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                    } else {
                      print(response.reasonPhrase);
                    }
                  },
                  child: Text(
                    'طلب عملية جراحية',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),
                //requestEmergencyTests
                ElevatedButton(
                  onPressed: () async {
                    var headers = {
                      'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
                      'token': 'eyJpZCI6MiwibmFtZSI6IkFtYnVsYW5jZSIsImNyZWF0ZWRfYXQiOiIyMDI0LTA1LTI4VDE5OjQ4OjIwLjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIn0=',
                    };

                    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/emrequest/test'));
                    request.fields.addAll({
                      'patient_id': '14',
                    });

                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                    } else {
                      print(response.reasonPhrase);
                    }
                  },
                  child: Text(
                    'طلب تحاليل إسعافية',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),

                //viewFileAttachments
                ElevatedButton(
                    onPressed: (){
                    },
                    child: Text(
                      'عرض مرفقات الملف الطبي',
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'حالة علاج سريع',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),),
        ],
   ), );
  }
}
