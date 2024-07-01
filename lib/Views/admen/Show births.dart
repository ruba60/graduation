import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Show_AllDeaths.dart';
import '../../Models/AllDeaths.dart';

import '../admen/dashboard.dart';

class BirthsRecordScreen extends StatefulWidget {
  @override
  _BirthsRecordScreenState createState() => _BirthsRecordScreenState();
}

class _BirthsRecordScreenState extends State<BirthsRecordScreen> {
  List<AllDeaths> d = [];
  ShowAllDeaths showalldeaths = ShowAllDeaths();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> fetchData() async {
    String myUrl = "$serverUrl/api/deaths/all";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
      'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjpudWxsLCJ1cGRhdGVkX2F0IjoiMjAyNC0wNS0yMVQxOTozOToxMS4wMDAwMDBaIn0='
    });
    final responseData = json.decode(response.body);
    print(responseData);
    setState(() {
      data = responseData;
    });
  }

  @override
  void initState() {
    showalldeaths.getData().then((deathsData) {
      setState(() {
        d = deathsData;
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            }),
        title: Text(
          'قسم الوفيات في المشفى الوطني للسويداء',
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
                itemCount: d.length,
                itemBuilder: (context, index) {
                  final deaths = d[index];
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
                                "سبب الوفاة: "
                                    "${deaths.reasonOfDeath}",
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
                                "تاريخ الوفاة: "
                                    "${deaths.deathDate}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),
                            Text(
                                "ساعة الوفاة: "
                                    "${deaths.deathHour}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),
                            Text(
                                "اسم الأب: "
                                    "${deaths.fatherName}",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),
                            Text(
                                "اسم الأم: "
                                    "${deaths.momName}",
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
