import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Controller/Add_Patient.dart';
import 'Ambulance.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();

}

class _AddPatientState extends State<AddPatient> {
  AddPatientController add =AddPatientController();

  List<String> dropdown = ['ذكر', 'انثى'];
  String v = 'ذكر';


  int _chain = 0;
  DateTime patientDate = DateTime.now();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // final TextEditingController dobController = TextEditingController();
  final TextEditingController momNameController = TextEditingController();

  final TextEditingController motherConroller = TextEditingController();
  final TextEditingController chainController = TextEditingController();
  final TextEditingController caseDescriptionController =
  TextEditingController();
  final TextEditingController treatmentRequiredController =
  TextEditingController();
  Future<void> addpatient(
      String full_name,
      String address,
      DateTime date_of_birth,
      String mom_name,
      String chain,
      String gender,
      String treatment_required,
      String case_description) async {
    var serverUrl = "http://127.0.0.1:8000";
    String myUrl = "$serverUrl/api/patient/add";
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'sessionKey' : 'IjY2M2E1ZjRkMjMzZjAi',
      'token':
      'eyJpZCI6MiwibmFtZSI6Ilx1MDY0Mlx1MDYzM1x1MDY0NSBcdTA2MjdcdTA2NDRcdTA2MjdcdTA2MzNcdTA2MzlcdTA2MjdcdTA2NDEiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9='
    }, body: {
      "full_name": full_name,
      "address": address,
      "date_of_birth": date_of_birth,
      "mom_name": mom_name,
      "chain": chain,
      "gender": gender,
      "case_description": case_description,
      "treatment_required": treatment_required,
    });
    final responseData = json.decode(response.body);
    print("response is ${responseData}");
    // setState(() {
    //   data = responseData;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AmbulanceScreen()),
              );
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        title: Text(
          'إضافة مريض',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.qr_code_scanner, color: Colors.white)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 200),
                height: 680,
                width: 1100,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Form(
                    //  key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  labelText: 'العنوان',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an address';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  addressController.text = value!;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: fullNameController,
                                decoration: InputDecoration(
                                  labelText: 'الإسم الثلاثي',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  fullNameController.text = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: patientDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null && picked != patientDate) {
                                    setState(() {
                                      patientDate = picked;
                                    });
                                  }
                                },
                                child: TextFormField(
                                  enabled: false,
                                  validator: (value) {
                                    if (value == null && value!.isEmpty) {}
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "${patientDate}",
                                    disabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide:
                                      BorderSide(color: Colors.blue),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 30.0),
                                    isDense: true,
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: motherConroller,
                                decoration: InputDecoration(
                                  labelText: 'اسم الأم',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a  mother name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  motherConroller.text = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'الجنس',
                                ),
                                items: dropdown
                                    .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a gender';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  v = value!;
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                // controller: chainController,
                                decoration: InputDecoration(
                                  labelText: 'القيد',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an chain';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _chain = int.parse(value!);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: caseDescriptionController,
                          decoration: InputDecoration(
                            labelText: 'وصف الحالة',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter status description ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            caseDescriptionController.text = value!;
                          },
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: treatmentRequiredController,
                          decoration: InputDecoration(
                            labelText: 'العلاج المقترح',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                addpatient(
                                    fullNameController.text,addressController.text,patientDate,
                                    momNameController.text,chainController.text, v,
                                    caseDescriptionController.text,
                                    treatmentRequiredController.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AmbulanceScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'حفظ البيانات',
                                style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
