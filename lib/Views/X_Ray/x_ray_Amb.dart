import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/xray_amb_model.dart';
import '../../controller/xray_Amb_controller.dart';

class X_Ray_Amb extends StatefulWidget {
  const X_Ray_Amb({super.key});

  @override
  State<X_Ray_Amb> createState() => _X_Ray_AmbState();
}

class _X_Ray_AmbState extends State<X_Ray_Amb> {
  TextEditingController searchController0 = TextEditingController();

  List<x_ray_Amb> x_ray_amb = [];
  ShowXray_Amb showx_ray_amb = ShowXray_Amb();
  List<dynamic> data1 = [];
  var serverUrl = "http://127.0.0.1:8000";

  @override
  void initState() {
    showx_ray_amb.fetchData().then((x_rayData) {
      setState(() {
        x_ray_amb = x_rayData!;
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
          'قسم الأشعة _ الطلبات الاسعافية ',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاسم الكامل',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text('اسم الام ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      )),

                  Text('الجنس ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      )),

                  Text('تاريخ الولادة ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      )),

                  //     Expanded(child: Text('patient_id' , style: TextStyle(fontWeight: FontWeight.w700, ),)),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              itemCount: x_ray_amb.length,
              itemBuilder: (context, index) {
                final xa = x_ray_amb[index];
                final patient = xa.patient!;
                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(' ${patient.fullName}'),
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
                  //          showx_ray_amb.sendHttpRequest1(xa.patientId!);
                    //        showx_ray_amb.sendHttpRequest11(xa.patientId!);

                            //عم يعطي خطا لانو ما في داتا , الريسبونس ما كامل
                        //    showx_ray_amb.sendHttpRequest11(xa.patientId!);
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
