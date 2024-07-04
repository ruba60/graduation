import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/residant_controller.dart';
import '../../Models/pationts_staying.dart';
import 'Resident patient.dart';

class ResidantPatientScreen extends StatefulWidget {
  const ResidantPatientScreen({super.key});

  @override
  State<ResidantPatientScreen> createState() => _ResidantPatientScreenState();
}

class _ResidantPatientScreenState extends State<ResidantPatientScreen> {
  TextEditingController searchController0 = TextEditingController();

  List<Resedent_pationt> residant = [];
  ResidantA residantA = ResidantA();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  @override
  void initState() {
    residantA.postData(shouldprint: true).then((ResidantData) {
      setState(() {
        residant = ResidantData;
      });
    }).catchError((error) {
      // Handle the error
      print('Error fetching patient data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30.0)
        ),
        child:  Column(
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
                onTap: () {},
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
                      'الاسم',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    // Expanded(
                    //   child: Text('الموعد المحدد ' , style: TextStyle(fontWeight: FontWeight.w700, )),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                itemCount: residant.length,
                itemBuilder: (context, index) {
                  final R = residant[index];
                  return Container(
                    color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                    child: ListTile(
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('  ${R.patientName}'),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print(R.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResidentPatient(R.id)),
                              );
                            },
                            child: Text(" عرض تفاصيل المريض"),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
