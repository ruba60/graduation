import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Show_AllDeaths.dart';


import '../../Controller/Show_All_Births.dart';
import '../../Models/All_Births.dart';
import '../admen/dashboard.dart';

class BirthsRecordScreen extends StatefulWidget {
  @override
  _BirthsRecordScreenState createState() => _BirthsRecordScreenState();
}

class _BirthsRecordScreenState extends State<BirthsRecordScreen> {
  List<AllBirths> b = [];
  ShowAllBirths showAllbirths = ShowAllBirths();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> fetchData() async {
    String myUrl = "$serverUrl/api/births/all";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
      'eyJpZCI6OCwibmFtZSI6IkFkbWlzc2lvbk1vbml0b3IiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    });
    final responseData = json.decode(response.body);
    print(responseData);
    setState(() {
      data = responseData;
    });
  }

  @override
  void initState() {
    showAllbirths.getData().then((birthsData) {
      setState(() {
        b = birthsData;
      });
    }).catchError((error) {
      // Handle the error
      print('Error fetching patient data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   automaticallyImplyLeading: false,
        backgroundColor: Colors.white60,
        centerTitle: true,


        title: Text(
          'قسم الولادات  في المشفى الوطني للسويداء',
          style: TextStyle(color: Colors.blue[600], fontSize: 20,fontWeight: FontWeight.bold),
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
                hintText: 'ابحث عن اسم...',
                icon: Icon(Icons.search, color: Colors.teal),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: []),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              width: 1200,
              child: ListView.builder(
                itemCount: b.length,
                itemBuilder: (context, index) {
                  final deaths = b[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.blue[100],
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'حذف',
                                    style: TextStyle(
                                        color: Colors.pink.shade500,
                                        fontSize: 16.0),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'طباعة التقرير',
                                    style: TextStyle(
                                        color: Colors.pink.shade500,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                                "الإسم: "
                                    "${deaths.name}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),


                            Text(
                                "مكان الولادة: "
                                    "${deaths.city}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),
                            Text(
                                "تاريخ الولادة: "
                                    "${deaths.birthDate}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),


                            Text(
                                "اسم الأب: "
                                    "${deaths.fatherName}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),
                            Text(
                                "اسم الأم: "
                                    "${deaths.motherName}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      onTap: () {
                        //   _showPatientDetails(context, patients[index]);
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
//   void _showPatientDetails(BuildContext context, Patient patient) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => PatientDetailsPage(patient: patient)),
//     );
//   }
// }
