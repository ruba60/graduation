import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Controller/Show_All_Department.dart';
import '../Models/all_department.dart';
import 'Ambulance/Ambulance.dart';
import 'HR/hr.dart';
import 'Permanent supervisor/m.dart';
import 'Store_Keeper/storekeeper.dart';
import 'Surgery/surgery.dart';
import 'Surgery/surgery_Amb.dart';
import 'Test_Lab/testlab.dart';
import 'Test_Lab/testlab_Amb.dart';
import 'X_Ray/x_ray_.dart';
import 'X_Ray/x_ray_Amb.dart';
import 'admen/dashboard.dart';

class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);

  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  String? _selectedDepartment;
  final _passwordController = TextEditingController();
  bool _isPasswordIncorrect = false; // Updated variable
  int? _selectedDepartmentId;

  List<AllDepartment> getalldepartment = [];
  ShowAllDepartment showAllDepartment = ShowAllDepartment();
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    _isPasswordIncorrect = false; // Initialize the variable

    showAllDepartment.getData().then((departmentsData) {
      setState(() {
        getalldepartment = departmentsData;
      });
    }).catchError((error) {
      // Handle the error
      print('Error fetching patient data: $error');
    });
  }

  Future<void> lon(int? id, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/login"),
        // Add 'http://' before the URL
        body: {
          'department_id': id.toString(),
          'password': password, // Remove the extra space after 'password'
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        String token = json.decode(response.body)['token'];
        // String token = response.headers['token']!;print(token);
        if (token == null) {
          print('hiiiii');
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print(token);

        // Navigate to the next screen
      } else {
        print(json.decode(response.body)['message']);
      }
    } catch (e) {
      print('Error:11 ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/5.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'مشفى زيد الشريطي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                    const SizedBox(height: 80.0),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5.0,
                            blurRadius: 7.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Text('اختر القسم'),
                            value: _selectedDepartment,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDepartment = newValue;
                                _selectedDepartmentId = getalldepartment
                                    .firstWhere((department) =>
                                        department.name == newValue)
                                    .id;
                              });
                            },
                            items: getalldepartment.map((getalldepartment) {
                              String departmentName =
                                  getalldepartment.name.toString();
                              return DropdownMenuItem<String>(
                                value: departmentName,
                                child: Text(departmentName),
                              );
                            }).toList(),
                            menuMaxHeight: 400,
                            itemHeight: 50,
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'كلمة المرور',
                            ),
                          ),
                          SizedBox(height: 20.0),
                          if (_isPasswordIncorrect)
                            Text(
                              'كلمة المرور غير صحيحة!',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              print(_selectedDepartmentId);
                              String password = _passwordController.text;

                              lon(_selectedDepartmentId, _passwordController.text).then((_) {
                                // تحقق من صحة القسم وكلمة المرور
                                if (_selectedDepartmentId == 1 && _passwordController.text == "12345") {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ),
                                  );
                                } else if (_selectedDepartmentId == 2 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>AmbulanceScreen(),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 4 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>X_Ray_Amb(),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 5 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>X_Ray(),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 6 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>TestLaB_Amb(),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 7 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>TestLaB (),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 8 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>morakeb(),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 9 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>StoreKeeper(),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 11 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>Hr(),
                                    ),
                                  );}
                                else if (_selectedDepartmentId == 16 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>Surgery(),
                                    ),
                                  );}else if (_selectedDepartmentId == 17 && _passwordController.text == password) {
                                  // اذا كانت القيم صحيحة، نقوم بتوجيه المستخدم الى الواجهة الصحيحة
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>SurgeryAmb(),
                                    ),
                                  );}
                                 else {
                                  // إذا كانت البيانات غير صحيحة، يتم تعيين قيمة _isPasswordIncorrect إلى true لعرض رسالة خطأ
                                  setState(() {
                                    _isPasswordIncorrect = true;
                                  });
                                }
                              }
                              );
                            },
                            child: Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
