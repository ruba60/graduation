import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Show_All_Department.dart';
import '../../Models/all_department.dart';

class Department {
  final String name;
  String password;

  Department(this.name, this.password);
}

class AddDepartmentScreen extends StatefulWidget {
  const AddDepartmentScreen({super.key});

  @override
  _AddDepartmentScreenState createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  List<AllDepartment> alldepartment = [];
  ShowAllDepartment showalldepartment = ShowAllDepartment();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<Department> departments = [
    Department('قسم 1', 'password1'),
    Department('قسم 2', 'password2'),
    Department('قسم 3', 'password3'),
  ];
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final GlobalKey<FormState> _editKey = GlobalKey();
  List<Department> searchResults = [];

  void searchDepartment(String searchTerm) {
    setState(() {
      searchResults = departments
          .where((department) =>
              department.name.contains(searchTerm) ||
              department.password.contains(searchTerm))
          .toList();
    });
  }

  // List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> deleteDep(int id) async {
    String myUrl = "$serverUrl/dep/delete";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      // 'Accept': 'application/json',
      'token':
          'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    }, body: {
      'dep_id': id,
    });
    final response1 = json.decode(response.body);
    print(response1);
  }

  Future<void> editPass(
    int id,
    String password,
  ) async {
    String myUrl = "$serverUrl//api/dep/updatepass";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    }, body: {
      "dep_id": id,
      "pass": password,
    });
    final responseData = json.decode(response.body);
    print(responseData);
  }

  Future<void> adddepartment(String name, String password) async {
    String myUrl = "$serverUrl/api/dep/create";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6MSwibmFtZSI6IklUQWRtaW4iLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    }, body: {
      "name": name,
      "password": password,
    });
    final responseData = json.decode(response.body);
    print(responseData);
  }

  @override
  void initState() {
    super.initState();
    showalldepartment.getData().then((AllDepData) {
      setState(() {
        alldepartment = AllDepData;
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
        automaticallyImplyLeading: false,
        title: Text(''),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: searchDepartment,
                          decoration: const InputDecoration(
                            labelText: 'ابحث عن قسم',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 150.0),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('إضافة قسم جديد'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'اسم القسم',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'كلمة السر',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue.shade700),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(48, 48), // Set the desired size
                                ),
                              ),
                              onPressed: () {
                                adddepartment(nameController.text,
                                    passwordController.text);
                              },
                              child: const Text(
                                'إضافة',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade700),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(48, 48), // Set the desired size
                    ),
                  ),
                  child: const Text(
                    'إضافة قسم',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(width: 50.0),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('تعديل كلمة المرور'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'اسم القسم',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'كلمة السر',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue.shade700),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(48, 48), // Set the desired size
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'تعديل',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade700),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(48, 48), // Set the desired size
                    ),
                  ),
                  child: const Text(
                    'تعديل كلمة المرور',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                itemCount: alldepartment.length,
                itemBuilder: (context, index) {
                  final S = alldepartment[index];
                  return Container(
                    color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                    child: ListTile(
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '${S.name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                              deleteDep(S.id ?? 0);
                            },
                            child: Icon(
                              Icons.delete,
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
      ),
    );
  }
}
