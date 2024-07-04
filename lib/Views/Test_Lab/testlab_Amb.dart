import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/testlabAmb_controller.dart';
import '../../Logout.dart';
import '../../Models/testlabAmb_model.dart';

class TestLaB_Amb extends StatefulWidget {
  const TestLaB_Amb({super.key});

  @override
  State<TestLaB_Amb> createState() => _TestLaB_AmbState();
}

class _TestLaB_AmbState extends State<TestLaB_Amb> {
  TextEditingController searchController0 = TextEditingController();

  List<TestLab_Amb> testlab_amb = [];
  ShowTestlab_Amb showTestlab_amb = ShowTestlab_Amb();
  List<dynamic> data = [];

  // var serverUrl = "http://127.0.0.1:8000";
  // Future<void> fetchData() async {
  //   String myUrl = "$serverUrl/api/emtest/all";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? '';
  //   http.Response response = await http.post(Uri.parse(myUrl), headers: {
  //     'Accept': 'application/json',
  //
  //     'token': 'eyJpZCI6NiwibmFtZSI6IkVtZXJnZW5jeVRlc3RMYWIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
  //   });
  //   final responseData = json.decode(response.body);
  //   print(responseData);
  //   setState(() {
  //     data = responseData;
  //   });
  // }

  @override
  void initState() {
    showTestlab_amb.getAllTestLabAmb().then((testlabData) {
      setState(() {
        testlab_amb = testlabData;
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
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainView()));
          },
        ),
        title: const Text(
          ' قسم التحاليل الطبية _ الحالات الاسعافية',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            width: 700,
            margin: const EdgeInsets.only(top: 50, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                label: Text('البحث عن مريض'),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            child: ListTile(
              subtitle: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'id',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 400),
                  Text('patient_id ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      )),
                  // Expanded(
                  //   child: Text('الموعد المحدد ' , style: TextStyle(fontWeight: FontWeight.w700, )),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              itemCount: testlab_amb.length,
              itemBuilder: (context, index) {
                final TA = testlab_amb[index];
                final TApatient = TA.patient!;
                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text('  ${TApatient.fullName}'),
                        ),
                        Expanded(
                          child: Text('${TApatient.momName}'),
                        ),
                        Expanded(
                          child: Text('${TApatient.gender}'),
                        ),
                        Expanded(
                          child: Text('${TApatient.dateOfBirth}'),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // showTestlab_amb.postDatatodelet(TA.id ?? 0) ;
                            showTestlab_amb.sendHttpRequest55(TA.patientId!);
                          },
                          child: Icon(
                            Icons.done,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Icon(
                        //     Icons.delete,
                        //     color: Colors.red,
                        //     size: 20,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
