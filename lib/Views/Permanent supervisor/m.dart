import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Logout.dart';
import '../../Models/Add_Patient.dart';
import '../../Models/patient.dart';
import 'Show births.dart';
import 'View deaths.dart';

class Patient {
  String name;
  int age;
  String diagnosis;
  PatientStatus status = PatientStatus.referred;
  String description;
  DateTime admissionDate;
  DateTime dischargeDate;

  Patient(
      {required this.name,
      required this.age,
      required this.diagnosis,
      required this.description,
      required this.admissionDate,
      required this.dischargeDate});
}



enum PatientStatus { referred, admitted, nursery }

class morakeb extends StatefulWidget {
  const morakeb({Key? key}) : super(key: key);

  @override
  State<morakeb> createState() => _morakebState();
}

class _morakebState extends State<morakeb> {
  List<AddPatient> _referredPatients = [];
  List<Patient> _nurseryPatients = [];
  // ignore: unused_field
  Patient? _selectedPatient;
  int _selectedIndex = 0;
  // ignore: unused_field
  int _contentIndex = 0;

  get serverUrl => null;

  @override
  // ignore: override_on_non_overriding_member
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    _loadReferredPatients();
  }

  Future<List<AddPatient>> getData() async {
    String myUrl = "http://127.0.0.1:8000/api/patient/all";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'token': token,
    });
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData.map((json) => AddPatient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch patient data');
    }
  }

  void _loadReferredPatients() {
    setState(() {
      getData().then((patientData) {
        setState(() {
          _referredPatients = patientData;
        });
      }).catchError((error) {
        // Handle the error
        print('Error fetching patient data: $error');
      });;
    });
  }

  void _selectPatient(Patient patient) {
    setState(() {
      _selectedPatient = patient;
    });
  }

  void _admitPatient(Patient patient) {
    setState(() {
      patient.status = PatientStatus.admitted;
      _selectedPatient = null;
    });
  }

  void _requestAdditionalTests(Patient patient) {
    setState(() {
      _contentIndex = 2;
    });
  }

  void _transferToNursery(Patient patient) {
    setState(() {
      patient.status = PatientStatus.nursery;
      _nurseryPatients.add(patient);
      _referredPatients.remove(patient);
      _selectedPatient = null;
    });
  }

  void _requestAdditionalXrays(Patient patient) {
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
      itemCount: _referredPatients.length,
      itemBuilder: (context, index) {
        final patient = _referredPatients[index];
        return ListTile(
          title: Text(patient.full_name as String),
          subtitle: Text(patient.case_description as String),
          onTap: () => _selectPatient(patient.treatment_required as Patient),
        );
      },
    );
  }

  Widget _buildNurseryPatientsList() {
    return ListView.builder(
      itemCount: _nurseryPatients.length,
      itemBuilder: (context, index) {
        final patient = _nurseryPatients[index];
        return ListTile(
          title: Text(patient.name),
          subtitle: Text('العمر: ${patient.age}'),
          onTap: () => _showPatientDetails(patient),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 1,
        ),
        height: 1500,
        decoration: const BoxDecoration(
            /* image: DecorationImage(
            image: AssetImage('images/ba.jpg'),
            fit: BoxFit.cover,
          ),*/
            ),
        child: Row(
          children: [
            // NavigationRail
            Container(
              //color: Colors.blue,
              height: 1000,
              width: 300, // عرض المستطيل
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.blue, // لون الخلفية أزرق
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),

                // إضافة حشوة داخل المستطيل
                child: NavigationRail(
                  minWidth: 72.0,
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
                        Icons.person,
                        color: Colors.white, // لون الأيقونة أبيض
                      ),
                      label: Text(
                        ' الوفيات',
                        style: TextStyle(color: Colors.white), // لون النص أبيض
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.baby_changing_station,
                        color: Colors.white, // لون الأيقونة أبيض
                      ),
                      label: Text(
                        'الولادات ',
                        style: TextStyle(color: Colors.white),
                        // onPressed: () => _transferToNursery(patient), // لون النص أبيض
                      ),
                    ),
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
                ),
              ),
            ),

            // واجهة المحتوى
            Expanded(
                child: _selectedIndex == 0
                    ? _buildPatientsList()
                    : _selectedIndex == 1
                        ? DeathRecordScreen()
                        : _selectedIndex == 2
                            ? BirthsRecordScreen()
                            : MainView()),
          ],
        ),
      ),
    );
  }

  //

  Widget _buildPatientsList() {
    return ListView.builder(
      itemCount: _referredPatients.length,
      itemBuilder: (context, index) {
        final patient = _referredPatients[index];

        return ListTile(
          title: Text(patient.full_name as String),
          subtitle: Text('العمر: ${patient.date_of_birth}'),
          onTap: () => _showPatientDetails(patient as Patient),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () => _admitPatient(patient as Patient),
                  child: Text('طباعة تقرير')),
            ],
          ),
        );
      },
    );
  }

  void _showPatientDetails(Patient patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${patient.name}'),
        content: Text(
          'العمر: ${patient.age}\n'
          'التشخيص: ${patient.diagnosis}\n'
          'الوصف: ${patient.description}\n'
          'تاريخ الدحول:${patient.admissionDate}\n'
          'تاريخ الخروج:${patient.dischargeDate}',
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
}


