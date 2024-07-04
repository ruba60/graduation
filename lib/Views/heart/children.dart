import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';


import '../../Controller/transfering_pationts.dart';
import '../../Logout.dart';
import '../../Models/Transfer_patints.dart';
import 'Patients staying in the department.dart';

class ChildrenSection extends StatefulWidget {
  @override
  State<ChildrenSection> createState() => _ChildrenSectionState();
}

class _ChildrenSectionState extends State<ChildrenSection> {
  String name='';

  List<Pationt_Tr> trpationts = [];
  transferpationts showpatientstaying = transferpationts();
  var serverUrl = "http://127.0.0.1:8000";

  Future<void> fetchData() async {
    String myUrl = "$serverUrl/api/dep/emptrlist";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String token = prefs.getString('token') ?? '';
    Map<String,dynamic> decodedToken = json.decode(utf8.decode(base64Decode(token)));
    name=decodedToken['name'];
    print(token);
    print(name);
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token':token
    });
    final responseData = json.decode(response.body);
    setState(() {
      trpationts = (responseData as List)
          .map((json) => Pationt_Tr.fromJson(json))
          .toList();
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Pationt_Tr? _selectedPatient;
  int _selectedIndex = 0;
  // ignore: unused_field
  int _contentIndex = 0;

  @override
  // ignore: override_on_non_overriding_member
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* void initState() {
    super.initState();
    _loadReferredPatients();
  }*/

  void _loadReferredPatients() {
    setState(() {
      trpationts = [];
    });
  }

  void _selectPatient(trpationts) {
    setState(() {
      _selectedPatient = trpationts;
    });
  }

/*  void _admitPatient(Transfairing_pationts patient) {
    setState(() {
      patient.status = PatientStatus.admitted;
      _selectedPatient = null;
    });
  }
*/
  /* void _transferToNursery(Transfairing_pationts patient) {
    setState(() {
      patient.status = PatientStatus.nursery;
      _nurseryPatients.add(patient);
      _referredPatients.remove(patient);
      _selectedPatient = null;
    });
  }*/

  void _requestAdditionalXrays(trpationts) {
    setState(() {
      _contentIndex = 4;
    });
  }

  // ignore: unused_field
  final List<String> _departments = [
    'اسعاف',
    'مراقب الدوام',
    'ادمن',
    'قسم الأطفال',
    'قسم الهضمية',
    'قسم العظمية',
    'قسم النسائية',
    'قسم الأشعة',
    'قسم المخابر',
    'قسم الجراحة',
    'قسم البولية',
    'قسم الصدرية',
    'قسم القلبية',
    'قسم الجلدية',
    'قسم الأعصاب',

    // Add other departments here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _contentIndex = index;
    });
  }

  Widget _buildReferredPatientsList() {
    return ListView.builder(
      itemCount: trpationts.length,
      itemBuilder: (context, index) {
        final tr_patient = trpationts[index];
        return ListTile(
          title: Text("${tr_patient.patientName}"),
          subtitle: Text("${tr_patient.fromDepName}"),
          // subtitle: Text("${tr_patient.fromDepName}"),

          onTap: () => _selectPatient(tr_patient),
        );
      },
    );
  }

  Widget _buildNurseryPatientsList() {
    return ListView.builder(
      itemCount: trpationts.length,
      itemBuilder: (context, index) {
        final patient = trpationts[index];
        return ListTile(
          title: Text("${patient.patientName}"),
          subtitle: Text('العمر: ${patient.fromDepName}'),
          onTap: () => _showPatientDetails(patient),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        title: Text(
          '${name}',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body:

      Container(
  decoration: BoxDecoration(
    // image: DecorationImage(
    //   // image: AssetImage('images/5.jpg'),
    //   fit: BoxFit.cover,
    //   colorFilter: ColorFilter.mode(
    //     Colors.black.withOpacity(0.5), // تعيين درجة الشفافية
    //     BlendMode.darken,
    //   ),
    // ),
  ),
  child:Row(
    children: [
      // NavigationRail
      Container(
        //color: Colors.blue,
        width: 350, // عرض المستطيل
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(18.0),
          color: Colors.white, // لون الخلفية أزرق
        ),
        child: NavigationRail(
          minWidth: 100.0,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          labelType: NavigationRailLabelType.all,
          backgroundColor: Colors.blue,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(
                Icons.home,
                color: Colors.white, // لون الأيقونة أبيض
              ),
              label: Text(
                'الصفحة الرئيسية',
                style: TextStyle(color: Colors.white), // لون النص أبيض
              ),
            ),
            NavigationRailDestination(
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
                // لون الأيقونة أبيض
              ),
              label: Text(
                ' المرضى المفيين',
                style: TextStyle(color: Colors.white), // لون النص أبيض
              ),
            ),
            /*  NavigationRailDestination(
                  icon: Icon(
                    Icons.notes,
                    color: Colors.white, // لون الأيقونة أبيض
                  ),
                  label: Text(
                    'الأقسام ',
                    style: TextStyle(color: Colors.white),
                    // onPressed: () => _transferToNursery(patient), // لون النص أبيض
                  ),
                ),*/
            NavigationRailDestination(
              icon: Icon(
                Icons.logout,
                color: Colors.white, // لون الأيقونة أبيض
              ),
              label: Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.white), // لون النص أبيض
              ),
            ),
          ],
          leading: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),

      // واجهة المحتوى
      Expanded(
          child:Container(
            padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/5.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), // تعيين درجة الشفافية
                    BlendMode.darken,
                  ),
                ),
              ),
              child:  _selectedIndex == 0
                  ? _buildPatientsList()
                  : _selectedIndex == 1
                  ? Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0), // إضافة BorderRadius
                  ),
                  child: const ResidantPatientScreen(),
                ),
              )
                  : MainView()),// your content here
          )
    ],
  ), // your content here
)


    );
  }

  //

  Widget _buildPatientsList() {
    setState(() {
      fetchData();
    });
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: ListView.builder(
        itemCount: trpationts.length,
        itemBuilder: (context, index) {
          final tr_patient = trpationts[index];
          final isEvenIndex = index % 2 == 0;
          final tileColor = isEvenIndex ? Colors.grey[100] : Colors.white;

          return Container(
            color: tileColor,
            child: ListTile(
              title: Text("${tr_patient.patientName}"),
              onTap: () => _showPatientDetails(tr_patient),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        // ignore: unused_local_variable
                        String token = prefs.getString('token') ?? '';
                        var headers = {
                          'sessionKey': 'IjY2M2E1ZjRkMjMzZjAi',
                          'token':
                              token,
                        };

                        var request = http.MultipartRequest(
                          'POST',
                          Uri.parse(
                              'http://127.0.0.1:8000/api/dep/accept_resident'),
                        );
                        request.fields.addAll({
                          'patient_id':
                              '${trpationts[index].patientId.toString()}',
                          'department_id':
                              '${trpationts[index].toDepId.toString()}',
                        });
                        request.headers.addAll(headers);

                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          _buildPatientsList();
                          print(await response.stream.bytesToString());
                        } else {
                          print(response.reasonPhrase);
                        }

                        // Implement the logic to admit the patient
                      },
                      child: const Text('قبول'),
                    ),
                  ),
                  const SizedBox(width: 3.5),
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        // ignore: unused_local_variable
                        String token = prefs.getString('token') ?? '';
                        var headers = {
                          'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
                          'token':
                              token,
                        };

                        var request = http.MultipartRequest(
                            'POST',
                            Uri.parse(
                                'http://127.0.0.1:8000/api/request/test'));
                        request.fields['patient_id'] =
                            '${trpationts[index].patientId.toString()}';
                        request.headers.addAll(headers);

                        var response = await request.send();

                        if (response.statusCode == 200) {
                          _buildPatientsList();
                          print(await response.stream.bytesToString());
                        } else {
                          print(response.reasonPhrase);
                        }
                      },
                      child: const Text('طلب تحاليل اضافية'),
                    ),
                  ),
                  const SizedBox(width: 3.5),
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        // ignore: unused_local_variable
                        String token = prefs.getString('token') ?? '';
                        var headers = {
                          'sessionKey': 'IjY2MTFmNTUzNmQzN2Ei',
                          'token':
                              token
                        };

                        var request = http.MultipartRequest(
                          'POST',
                          Uri.parse('http://127.0.0.1:8000/api/request/test'),
                        );
                        request.fields.addAll({
                          'patient_id':
                              '${trpationts[index].patientId.toString()}',
                        });
                        request.headers.addAll(headers);

                        var response = await request.send();

                        if (response.statusCode == 200) {
                          _buildPatientsList();
                          print(await response.stream.bytesToString());
                        } else {
                          print(response.reasonPhrase);
                        }
                      },
                      child: const Text('طلب تصوير اشعة'),
                    ),
                  ),
                  const SizedBox(width: 3.5),
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        // ignore: unused_local_variable
                        String token = prefs.getString('token') ?? '';
                        var headers = {
                          'token':
                              token
                        };

                        var request = http.MultipartRequest('POST',
                            Uri.parse('http://127.0.0.1:8000/api/surgery/add'));
                        request.fields['patient_id'] =
                            '${trpationts[index].patientId.toString()}';
                        request.headers.addAll(headers);

                        var response = await request.send();

                        if (response.statusCode == 200) {
                          _buildPatientsList();
                          print(await response.stream.bytesToString());
                        } else {
                          print(response.reasonPhrase);
                        }
                      },
                      child: const Text('طلب عملية'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPatientDetails(Pationt_Tr patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${patient.patientName}'),
        content: Text(
          'رقم: ${patient.patientId}\n'
          'من: ${patient.fromDepName}\n'
          'الى: ${patient.toDepName}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _requestAdditionalTests(Pationt_Tr patient) {
    // Implement the logic to request additional tests for the patient
  }

  void _requestXRay(Pationt_Tr patient) {
    // Implement the logic to request an X-Ray for the patient
  }

  void _transferToIncubator(Pationt_Tr patient) {
    // Implement the logic to transfer the patient to the incubator
  }
}

class LogoutWidget extends StatefulWidget {
  // final Function onLogoutConfirmed; // Callback for successful logout

  const LogoutWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  final _departments = [
    'اسعاف',
    'مراقب الدوام',
    'ادمن',
    'قسم الأطفال',
    'قسم الهضمية',
    'قسم العظمية',
    'قسم النسائية',
    'قسم الأشعة',
    'قسم المخابر',
    'قسم الجراحة',
    'قسم البولية',
    'قسم الصدرية',
    'قسم القلبية',
    'قسم الجلدية',
    'قسم الأعصاب',
  ]; // Replace with actual departments
  String? _selectedDepartment;
  final _passwordController = TextEditingController();
  bool _isPasswordIncorrect = false;

  void _handleLogoutPressed() async {
    // Simulate authentication logic (replace with actual API call or verification)
    if (_selectedDepartment != null &&
        _passwordController.text == 'correct_password') {
      setState(() {
        _isPasswordIncorrect = false;
      });
      //widget.onLogoutConfirmed(); // Call the callback to handle logout actions
    } else {
      setState(() {
        _isPasswordIncorrect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('الانتقال الى قسم اخر'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedDepartment,
            decoration: InputDecoration(labelText: 'اختر القسم'),
            items: _departments.map((String department) {
              return DropdownMenuItem<String>(
                value: department,
                child: Text(department),
              );
            }).toList(),
            onChanged: (String? newValue) =>
                setState(() => _selectedDepartment = newValue),
            validator: (value) => value == null ? 'يجب اختيار قسم' : null,
          ),
          SizedBox(height: 30),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              errorText: _isPasswordIncorrect ? 'كلمة المرور غير صحيحة' : null,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: _handleLogoutPressed,
            child: Text(' تاكيد'),
          ),
        ],
      ),
    );
  }
}
