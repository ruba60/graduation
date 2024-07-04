import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


import '../../Controller/Show_All_Department.dart';
import '../../Models/all_department.dart';
import 'AddPatient.dart';
import 'Ambulance.dart';



class PatientDetailsPage extends StatefulWidget {

  String? full_name;
 String? caseDescription;
 String? treatmentRequired;
 String? id;
  PatientDetailsPage({super.key, required this.full_name,
    required this.caseDescription,
    required this.treatmentRequired,
    required this.id,
  });

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {


// final Patient patient;
  String? _selectedDepartment;
  int? _selectedDepartmentId;
  ShowAllDepartment showAllDepartment = ShowAllDepartment();

  List<AllDepartment> getalldepartment = [];

  //PatientDetailsPage({required this.patient});

  TextEditingController textController = TextEditingController();


  @override
  void initState() {
    super.initState();


    showAllDepartment.getData().then((departmentsData) {
      setState(() {
        getalldepartment = departmentsData;
      });
    }).catchError((error) {
      // Handle the error
      print('Error fetching patient data: $error');
    });
  }

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
                    Text("${widget.caseDescription}",
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
                    Text( "${widget.treatmentRequired}",
                        style:
                        TextStyle(fontSize: 15, color: Colors.black)),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Add()));
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
                                  DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    hint: Text('اختر القسم'),
                                    value: _selectedDepartment,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedDepartment = newValue;
                                        _selectedDepartmentId = getalldepartment
                                            .firstWhere((department) =>
                                        department.name == newValue)
                                            .id;
                                      });
                                    },
                                    items: getalldepartment.map((getalldepartment) {
                                      String departmentName =
                                      getalldepartment.name.toString();
                                      return DropdownMenuItem<String>(
                                        value: departmentName,
                                        child: Text(departmentName),
                                      );
                                    }).toList(),
                                    menuMaxHeight: 400,
                                    itemHeight: 50,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () async {// Construct the request
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    String token = prefs.getString('token') ?? '';
                                    var authHeaders = {
                                      'sessionKey': 'IjY2MmI2NTk3NjM4ZjIi',
                                      'token': token
                                    };

                                    http.Response response = http.post(Uri.parse('http://127.0.0.1:8000/api/patient/emtransfer')
                                      ,body:{
                                        'patient_id':'${widget.id}',
                                        'tr_department': '${_selectedDepartmentId}'
                                    },
                                    headers:
                                    {
                                      'token' : token
                                    }) as http.Response;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>AmbulanceScreen(),
                                      ),);
// Send the requ
                                    if (response.statusCode == 200) {
                                      print('hi');
                                    } else {
                                    print('hiii');
                                    }

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

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String token = prefs.getString('token') ?? '';
                    var headers = {
                      'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
                      'token': token,
                    };

                    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/emrequest/xray'));
                    request.fields.addAll({
                      'patient_id': '${widget.id}',
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
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String token = prefs.getString('token') ?? '';
                    var headers = {
                      'token': token,
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
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String token = prefs.getString('token') ?? '';
                    var headers = {
                      'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
                      'token': token,
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
