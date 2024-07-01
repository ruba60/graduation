import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

import '../../Controller/testlab_controller.dart';
import '../../Models/testlabmodel.dart';

class TestLaB extends StatefulWidget {
  const TestLaB({super.key});

  @override
  State<TestLaB> createState() => _TestLaBState();
}

class _TestLaBState extends State<TestLaB> {

  TextEditingController searchController0 = TextEditingController();

  List<TestLab> testlab = [];
  ShowTestlab showTestlab = ShowTestlab();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  // Future<void> fetchData() async {
  //   String myUrl = "$serverUrl/api/test/all";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? '';
  //   http.Response response = await http.post(Uri.parse(myUrl), headers: {
  //     'Accept': 'application/json',
  //
  //     'token': 'eyJpZCI6NywibmFtZSI6IlRlc3RMYWIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
  //   });
  //   final responseData = json.decode(response.body);
  //   print(responseData);
  //   setState(() {
  //     data = responseData;
  //   });
  // }

  @override
  void initState() {
    showTestlab.getAllTests().then((testlabData) {
      setState(() {
        testlab = testlabData! ;
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
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: const Text(
          'قسم التحاليل الطبية',
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

          Container( padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            child: ListTile(
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الاسم الكامل' , style: TextStyle(fontWeight: FontWeight.w700, ),),

                  Text('اسم الام ', style: TextStyle(fontWeight: FontWeight.w700, )),
                  Text('الجنس ', style: TextStyle(fontWeight: FontWeight.w700, )),

                  Text('تاريخ الولادة ', style: TextStyle(fontWeight: FontWeight.w700, )),

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
              itemCount: testlab.length,
              itemBuilder: (context, index) {

                final T = testlab[index];
                final Tp = T.patient! ;
                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text('${Tp.fullName}'),
                        ),
                        Expanded(
                          child: Text(' ${Tp.momName} '),
                        ),

                        Expanded(
                          child: Text(' ${Tp.gender} '),
                        ),
                        Expanded(
                          child: Text(' ${Tp.dateOfBirth} '),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        ElevatedButton(
                          onPressed: () {

                       //     showTestlab.sendHttpRequest2(Tp.id!);
                            showTestlab.sendHttpRequest22(T.patientId!);

                          },
                          child: Icon(
                            Icons.done,

                            color: Colors.blueAccent,

                          ),
                        ),
                        SizedBox(width:  20.0 ,),

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
