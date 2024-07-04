import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;


import '../../Controller/surgery_controller.dart';
import '../../Logout.dart';
import '../../Models/surgery_model.dart';


class Surgery extends StatefulWidget {
  const Surgery({super.key});

  @override
  State<Surgery> createState() => _SurgeryAmbState();
}

class _SurgeryAmbState extends State<Surgery> {

  TextEditingController searchController0 = TextEditingController();

  List<Surgery_model> surgery = [];
  ShowSurgery showSurgery = ShowSurgery();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";


  @override
  void initState() {
    showSurgery.getAllSurgeries().then((surgaryData) {
      setState(() {
        surgery = surgaryData ;
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
        backgroundColor: Colors.blue,
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
          'قسم العمليات الجراحية',
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
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الاسم الكامل ' , style: TextStyle(fontWeight: FontWeight.w700, ),),
                  SizedBox(width:200),
                  Text('اسم الام ', style: TextStyle(fontWeight: FontWeight.w700, )),
                  // Expanded(
                  //   child: Text('الموعد المحدد ' , style: TextStyle(fontWeight: FontWeight.w700, )),
                  // ),
                  SizedBox(width:200),
                  Text('الجنس' , style: TextStyle(fontWeight: FontWeight.w700, ),),
                  SizedBox(width:200),
                  Text('تاريخ الولادة ', style: TextStyle(fontWeight: FontWeight.w700, )),

                ],
              ),

            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              itemCount: surgery.length,
              itemBuilder: (context, index) {

                final SA = surgery[index];

                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text('  ${SA.fullName}'),
                        ),
                        Expanded(
                          child: Text('${SA.momName}'),
                        ),
                        Expanded(
                          child: Text('${SA.gender}'),
                        ),
                        Expanded(
                          child: Text('${SA.dateOfBirth}'),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        ElevatedButton(
                          onPressed: () {
                            showSurgery.sendHttpRequest66(SA.id!);
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
