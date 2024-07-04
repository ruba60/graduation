import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

import 'package:shared_preferences/shared_preferences.dart';


import '../../Controller/surgery_Amb_controller.dart';
import '../../Logout.dart';
import '../../Models/surgary_Amb_model.dart';


class SurgeryAmb extends StatefulWidget {
  const SurgeryAmb({super.key});

  @override
  State<SurgeryAmb> createState() => _SurgeryAmbState();
}

class _SurgeryAmbState extends State<SurgeryAmb> {

  TextEditingController searchController0 = TextEditingController();

  List<Surgery_Amb> surgery_amb = [];
  ShowSurgery_Amb showSurgery_Amb = ShowSurgery_Amb();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> fetchData() async {
    String myUrl = "$serverUrl/api/surgery/emall";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',

      'token':token
    });
    final responseData = json.decode(response.body);
    print(responseData);

  }

  @override
  void initState() {
    showSurgery_Amb.getData().then((surgaryData) {
      setState(() {
        surgery_amb = surgaryData ;
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
          'قسم العمليات الجراحية _ الحالات الاسعافية',
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
                  Text('id' , style: TextStyle(fontWeight: FontWeight.w700, ),),
                  SizedBox(width:350),
                  Text('patient_id ', style: TextStyle(fontWeight: FontWeight.w700, )),
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
              itemCount: surgery_amb.length,
              itemBuilder: (context, index) {

                final S = surgery_amb[index];
               // final SP = S.patient! ;
                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text('  ${S.id}'),
                        ),
                        Expanded(
                          child: Text('${S.patientId}'),
                        ),
                        Expanded(
                          child: Text(''),
                        ),

                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        ElevatedButton(
                          onPressed: () {

                            showSurgery_Amb.sendHttpRequest77(S.patientId!);
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
