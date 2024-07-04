import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../../Controller/x_raycontroller.dart';
import '../../Logout.dart';
import '../../Models/x_raymodel.dart';


class X_Ray extends StatefulWidget {
  const X_Ray({super.key});

  @override
  State<X_Ray> createState() => _X_RayState();
}

class _X_RayState extends State<X_Ray> {
  TextEditingController searchController0 = TextEditingController();

  List<X_ray> x_rays = [];
  ShowXray showx_ray = ShowXray();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  @override
  void initState() {
    showx_ray.fetchData().then((storeData) {
      setState(() {
        x_rays = storeData!;
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
          'قسم الأشعة',
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
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      ' الاسم الكامل',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text('الام  ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Expanded(
                    child: Text('الجنس ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Expanded(
                    child: Text('تاريخ الولادة  ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              itemCount: x_rays.length,
              itemBuilder: (context, index) {
                final x_ray = x_rays[index];
                final patient = x_ray.patient!;
                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: Text(' ${x.patientName}'),
                        // ),
                        Expanded(
                          child: Text('${patient.fullName}'),
                        ),
                        Expanded(
                          child: Text(' ${patient.momName} '),
                        ),

                        Expanded(
                          child: Text(' ${patient.gender} '),
                        ),
                        Expanded(
                          child: Text(' ${patient.dateOfBirth} '),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // int? patientId = x_ray.patientId;
                          showx_ray.sendHttpRequest(x_ray.patientId!);
                            ;
                          },
                          child: Icon(
                            Icons.done,
                            color: Colors.blueAccent,
                          ),
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
    );
  }
}
