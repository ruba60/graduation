import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/storekeepermodel.dart';
import '../../controller/storekeepercontroller.dart';

class StoreKeeper extends StatefulWidget {
  const StoreKeeper({super.key});

  @override
  State<StoreKeeper> createState() => _StoreKeeperState();
}

class _StoreKeeperState extends State<StoreKeeper> {
  TextEditingController searchController = TextEditingController();
  TextEditingController name_drag_Controller = TextEditingController();
  TextEditingController quantity_drag_Controller = TextEditingController();
  TextEditingController expiryDate_drag_Controller = TextEditingController();
  TextEditingController company_drag_Controller = TextEditingController();
  TextEditingController availabilityStatus_controller = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();
  final GlobalKey<FormState> _editKey = GlobalKey();

  List<Storekeeper> store = [];
  ShowStoreKeeper showstorekeeper = ShowStoreKeeper();
  List<dynamic> data = [];
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> addData(String name, String end_date, String company,
      String quantity, ) async {
    String myUrl = "$serverUrl/api/resources/store";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    try {
      http.Response response = await http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'token':
            'eyJpZCI6OSwibmFtZSI6Ik1lZGljaW5lU3RvcmVLZWVwZXIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
      }, body: {
        "name": name,
        "end_date": end_date,
        "company": company,
        "quantity": quantity,
      });
      final responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        print("Sa");
        data = json.decode(responseData);
        store.add(json.decode(responseData));
      });
    } catch (e) {
      print("Error" + e.toString());
    }
  }


  // Future<void> addData(String name, String end_date, String company,
  //     String quantity, String availabilityStatus) async {
  //   String myUrl = "$serverUrl/api/resources/store";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? '';
  //   try {
  //     http.Response response = await http.post(Uri.parse(myUrl), headers: {
  //       'Accept': 'application/json',
  //       'token':
  //       'eyJpZCI6OSwibmFtZSI6Ik1lZGljaW5lU3RvcmVLZWVwZXIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
  //     }, body: {
  //       "name": name,
  //       "end_date": end_date,
  //       "company": company,
  //       "quantity": quantity,
  //     });
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     setState(() {
  //       print("Sa");
  //       data = json.decode(responseData);
  //       store.add(json.decode(responseData));
  //     });
  //   } catch (e) {
  //     print("Error" + e.toString());
  //   }
  // }


  Future<void> editData(String id, String name, String quantity,) async {
    String myUrl =
        "$serverUrl/api/resources/update/$id"; // تعديل على عنوان الطلب إلى تضمين معرف العنصر المعدّل
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    try {
      http.Response response = await http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'token':
            'eyJpZCI6OSwibmFtZSI6Ik1lZGljaW5lU3RvcmVLZWVwZXIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
        //
      }, body: {
        "name": name,

        "quantity": quantity,
        // يمكنك إضافة حقول أخرى حسب احتياجاتك

        // يمكنك تمرير حالة التوفر كحقل منفصل أو تضمينها في الحقل quantity بتنسيق معين
        // "availabilityStatus": availabilityStatus,
        // أو يمكنك تعديل الحقل quantity بناءً على حالة التوفر
        // "quantity": availabilityStatus == 'available' ? quantity : '0',
      });
      final responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        print("Sa");
        // تحديث البيانات المحلية إذا كان هناك حاجة لذلك
        // قد تحتاج إلى تعديل الكود وفقًا لهيكل البيانات الخاص بك
        // data = json.decode(responseData);
        // store.add(json.decode(responseData));
      });
    } catch (e) {
      print("Error" + e.toString());
    }
  }




  // Future<void> editData(String name, int quantity,int availability_status,int id) async {
  //   String myUrl = "$serverUrl/api/resources/update/${id}";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? '';
  //   http.Response response = await http.post(Uri.parse(myUrl), headers: {
  //     'Accept': 'application/json',
  //     'token':
  //     'eyJpZCI6OSwibmFtZSI6Ik1lZGljaW5lU3RvcmVLZWVwZXIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
  //   }, body: {
  //     "name": name,
  //     "quantity": quantity,
  //     "availability_status" : availability_status,
  //   });
  //   final responseData = json.decode(response.body);
  //   print(responseData);
  //   // setState(() {
  //   //   data = responseData;
  //   // });
  // }

  //معدل
  Future<void> deleteData(int id) async {
    String myUrl = "$serverUrl/api/resources/delete/${id}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.delete(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':
          'eyJpZCI6OSwibmFtZSI6Ik1lZGljaW5lU3RvcmVLZWVwZXIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wNS0yOFQxOTo0ODoyMC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjQtMDUtMjhUMTk6NDg6MjAuMDAwMDAwWiJ9'
    });
    // final responseData = json.decode(response.body);
    // print(responseData);
    // setState(() {
    //   data = responseData;
    // });
  }


  @override
  void initState() {
    showstorekeeper.getData().then((storeData) {
      setState(() {
        store = storeData;
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
        title: Text("مستودع الأدوية و المستلزمات الطبية "),
      ),
      body: Column(
        children: [
          Container(
            // padding: EdgeInsets.all(50),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                label: const Text('البحث عن دواء'),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onChanged: (value) {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              itemCount: store.length,
              itemBuilder: (context, index) {
                final s = store[index];
                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    title: Text("${s.name}"),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: Text('الوصف:  ${s.}'),
                        // ),
                        Expanded(
                          child: Text('الكمية المتاحة  :  ${s.quantity}'),
                        ),
                        Expanded(
                          child: Text('تاريخ الانتهاء : ${s.endDate}'),
                        ),
                        Expanded(
                          child: Text('الشركة المصنعة : ${s.company} '),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.mode_edit_outline_outlined),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("تعديل دواء "),
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: SingleChildScrollView(
                                        child: Form(
                                          key: _editKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              //name
                                              TextFormField(
                                                controller:
                                                    name_drag_Controller,
                                                decoration: InputDecoration(
                                                    labelText: 'الاسم  '),
                                              ),

                                              //quantity
                                              TextFormField(
                                                controller:
                                                    quantity_drag_Controller,
                                                decoration: InputDecoration(
                                                    labelText: 'الكمية  '),
                                              ),

                                              //expriy_date
                                              // TextFormField(
                                              //   controller:
                                              //       expiryDate_drag_Controller,
                                              //   decoration: InputDecoration(
                                              //       labelText:
                                              //           'تاريخ الانتهاء   '),
                                              // ),

                                              //company
                                              // TextFormField(
                                              //   controller:
                                              //       company_drag_Controller,
                                              //   decoration: InputDecoration(
                                              //       labelText: 'الشركة  '),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("إلغاء")),
                                      TextButton(
                                          onPressed: () {
                                            //   editData(name_drag_Controller.text,int.parse(quantity_drag_Controller.text) as String, (s.id ?? 0) as String);
                                            // if (_globalKey.currentState!
                                            //     .validate()) {
                                            //   setState(() {
                                            //
                                            //   });
                                            //   Navigator.of(context).pop();
                                            // }
                                          //  editData( (s.id ?? 0) as String,name_drag_Controller.text, quantity_drag_Controller.text);
                                            editData(s.id.toString(), name_drag_Controller.text, quantity_drag_Controller.text);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("حفظ التعديلات")),
                                    ],
                                  );
                                });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deleteData(s.id ?? 0);
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('إضافة دواء  '),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى ادخال  اسم الدواء ';
                              }
                              return null;
                            },
                            controller: name_drag_Controller,
                            decoration:
                                const InputDecoration(labelText: 'الاسم '),
                          ),

                          //expriy_date
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى ادخال  تاريخ الانتهاء ';
                              }
                              return null;
                            },
                            controller: expiryDate_drag_Controller,
                            decoration: const InputDecoration(
                                labelText: 'تاريخ الانتهاء(YYYY-MM-DD)'),
                            //    keyboardType: TextInputType.datetime,
                          ),

                          //company
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى ادخال الشركة المصنعة ';
                              }
                              return null;
                            },
                            controller: company_drag_Controller,
                            decoration: const InputDecoration(
                                labelText: 'الشركة المصنعة'),
                          ),

                          //quantity
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى ادخال  الكمية الموجودة ';
                              }
                              return null;
                            },

                            controller: quantity_drag_Controller,
                            decoration:
                                const InputDecoration(labelText: 'الكمية '),
                            //  keyboardType: TextInputType.number,
                          ),

                          //availability
                          // TextFormField(
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'يرجى ادخال  الكمية الموجودة ';
                          //     }
                          //     return null;
                          //   },
                          //
                          //   controller: availabilityStatus_controller,
                          //   decoration:
                          //       const InputDecoration(labelText: 'الاتاحية '),
                          //   //  keyboardType: TextInputType.number,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('إلغاء'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('إضافة'),
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        addData(
                          name_drag_Controller.text,
                          expiryDate_drag_Controller.text,
                          company_drag_Controller.text,
                          quantity_drag_Controller.text,
                          // availabilityStatus_controller.text,
                        );

                        print("done");
                        // تنفيذ الإجراء المطلوب عند صحة البيانات
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),

// ... (الكود السابق)
    );
  }
}

class Drug {
  String name;
  String description;
  int quantity;
  DateTime expiryDate;
  String company;

  Drug(this.name, this.description, this.quantity, this.expiryDate,
      this.company);
}
