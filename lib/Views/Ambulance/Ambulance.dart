import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../../Controller/show_patient.dart';
import '../../Models/Add_Patient.dart';
import '../../login.dart';


import '../../Models/patient.dart';

import '../admen/dashboard.dart';
import '../login2.dart';
import 'AddPatient.dart';
import 'PatientDetailsPage.dart';


class Patient {
  final String name;
  final String status;
  final String treatment;
  final String entryTime;

  Patient({
    required this.name,
    required this.status,
    required this.treatment,
    required this.entryTime,
  });
}

class AmbulanceScreen extends StatefulWidget {
  @override
  _AmbulanceScreenState createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {
  String? _selectedDepartment;

  List<AddPatient> p = [];
  ShowPatient showPatient = ShowPatient();
  final _passwordController = TextEditingController();
  bool? _isPasswordIncorrect;

  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> fetchData() async {
    print('hi');
    String myUrl = "$serverUrl/api/dep/patients";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          token,
    });
    final responseData = json.decode(response.body);
    print(responseData);
    setState(() {
      data = responseData;
    });
  }

  @override
  void initState() {
    super.initState();
    _isPasswordIncorrect = false; // Initialize the variable
    showPatient.getData().then((patientData) {
      setState(() {
        p = patientData;
      });
    }).catchError((error) {
      // Handle the error
      print('Error fetching patient data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        leading:
        IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String token = prefs.getString('token') ?? '';
            var headers = {
              'sessionKey': 'IjY2M2E1ZjRkMjMzZjAi',
              'token':
              token,
            };
            var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/logout'));

            request.headers.addAll(headers);

            http.StreamedResponse response = await request.send();

            if (response.statusCode == 200) {

    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Log()),
    );
              print(await response.stream.bytesToString());
            } else {
            print(response.reasonPhrase);
            }
          },
        ),
        title: Text(
          'قسم الإسعاف في المشفى الوطني للسويداء',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            width: 500,
            margin: const EdgeInsets.only(top: 50, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'ابحث عن مريض...',
                icon: Icon(Icons.search, color: Colors.teal),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Positioned(
                left: 16.0,
                right: 16.0,
                top: 32.0,
                bottom: 32.0,
                child:
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Add()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue.shade700),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Positioned(
                      left: 32.0,
                      right: 32.0,
                      top: 32.0,
                      bottom: 32.0,
                      child:Text(
                        'إضافة مريض',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                ),
                ]),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              width: 1200,
              child: ListView.builder(
                itemCount: p.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${p[index].full_name}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${p[index].case_description}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // إجراء العمل عند الضغط على الزر "العرض"
                            },
                            child: Text('العرض'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // إجراء العمل عند الضغط على الزر "تعديل"
                            },
                            child: Text('تعديل'),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientDetailsPage(
                              full_name: p[index].full_name,
                              treatmentRequired: p[index].treatment_required,
                              caseDescription: p[index].case_description,
                              id: p[index].id.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
