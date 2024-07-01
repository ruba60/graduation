import 'package:flutter/material.dart';


import '../admen/Show births.dart';
import '../admen/View deaths.dart';
import 'Show births.dart';

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

List<Patient> _nurseryPatients = [
  Patient(
      name: 'خالد',
      age: 3,
      diagnosis: 'التهاب رئوي',
      description: 'يعاني من صعوبة في التنفس وحرارة مرتفعة',
      admissionDate: DateTime(2022, 05, 01),
      dischargeDate: DateTime(2022, 05, 10)),
  Patient(
      name: 'لينا',
      age: 1,
      diagnosis: 'فقر الدم',
      description: 'تعاني من شحوب وإرهاق شديد',
      admissionDate: DateTime(2022, 04, 15),
      dischargeDate: DateTime(2022, 04, 30)),
  Patient(
      name: 'سليم',
      age: 5,
      diagnosis: 'حساسية الغذاء',
      description: 'يعاني من طفح جلدي وانتفاخ في الوجه',
      admissionDate: DateTime(2022, 03, 20),
      dischargeDate: DateTime(2022, 04, 05)),
];

enum PatientStatus { referred, admitted, nursery }

class morakeb extends StatefulWidget {
  const morakeb({Key? key}) : super(key: key);

  @override
  State<morakeb> createState() => _morakebState();
}

class _morakebState extends State<morakeb> {
  List<Patient> _referredPatients = [];
  List<Patient> _nurseryPatients = [];
  // ignore: unused_field
  Patient? _selectedPatient;
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

  void initState() {
    super.initState();
    _loadReferredPatients();
  }

  void _loadReferredPatients() {
    setState(() {
      _referredPatients = [
        Patient(
            name: 'علي',
            age: 10,
            diagnosis: 'نزلات برد',
            description: 'يعاني من سعال وحرارة',
            admissionDate: DateTime(2022, 03, 20),
            dischargeDate: DateTime(2022, 04, 05)),
        Patient(
            name: 'فاطمة',
            age: 5,
            diagnosis: 'التهاب رئوي',
            description: 'يعاني من صعوبة في التنفس',
            admissionDate: DateTime(2022, 03, 20),
            dischargeDate: DateTime(2022, 04, 05)),
        Patient(
            name: 'أحمد',
            age: 8,
            diagnosis: 'جروح',
            description: 'يعاني من جروح في الوجه واليدين',
            admissionDate: DateTime(2022, 03, 20),
            dischargeDate: DateTime(2022, 04, 05)),
      ];
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
          title: Text(patient.name),
          subtitle: Text(patient.diagnosis),
          onTap: () => _selectPatient(patient),
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
                            ? BirthRecordScreen()
                            : LogoutWidget()),
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
          title: Text(patient.name),
          subtitle: Text('العمر: ${patient.age}'),
          onTap: () => _showPatientDetails(patient),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () => _admitPatient(patient),
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
      title: const Text('الانتقال الى قسم اخر'),
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
