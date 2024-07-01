// import 'package:flutter/material.dart';
//
// import '../../Babysitter.dart';
// import '../../Patients staying in the department.dart';
//
// class Patient {
//   String name;
//   int age;
//   String diagnosis;
//   PatientStatus status = PatientStatus.referred;
//   String description;
//
//   Patient({
//     required this.name,
//     required this.age,
//     required this.diagnosis,
//     required this.description,
//   });
// }
//
// List<Patient> _nurseryPatients = [
//   Patient(
//     name: 'خالد',
//     age: 3,
//     diagnosis: 'التهاب رئوي',
//     description: 'يعاني من صعوبة في التنفس وحرارة مرتفعة',
//   ),
//   Patient(
//     name: 'لينا',
//     age: 1,
//     diagnosis: 'فقر الدم',
//     description: 'تعاني من شحوب وإرهاق شديد',
//   ),
//   Patient(
//     name: 'سليم',
//     age: 5,
//     diagnosis: 'حساسية الغذاء',
//     description: 'يعاني من طفح جلدي وانتفاخ في الوجه',
//   ),
// ];
//
// enum PatientStatus { referred, admitted, nursery }
//
// class ChildrenSection extends StatefulWidget {
//   const ChildrenSection({Key? key}) : super(key: key);
//
//   @override
//   State<ChildrenSection> createState() => _ChildrenSectionState();
// }
//
// class _ChildrenSectionState extends State<ChildrenSection> {
//   List<Patient> _referredPatients = [];
//   List<Patient> _nurseryPatients = [];
//   // ignore: unused_field
//   Patient? _selectedPatient;
//   int _selectedIndex = 0;
//   // ignore: unused_field
//   int _contentIndex = 0;
//
//   @override
//   // ignore: override_on_non_overriding_member
//   void _onNavItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   MedicalRecord _createMedicalRecord(String childName) {
//     return MedicalRecord(
//       childName: childName,
//       appointments: [
//         Appointment(
//           date: DateTime.now(),
//           doctorName: 'د. علي',
//           description: 'فحص دوري',
//         ),
//       ],
//       medications: [
//         Medication(
//           name: 'باراسيتامول',
//           dosage: '5 مل',
//           instructions: 'كل 8 ساعات',
//         ),
//       ],
//     );
//   }
//
//   void initState() {
//     super.initState();
//     _loadReferredPatients();
//   }
//
//   void _loadReferredPatients() {
//     setState(() {
//       _referredPatients = [
//         Patient(
//           name: 'علي',
//           age: 10,
//           diagnosis: 'نزلات برد',
//           description: 'يعاني من سعال وحرارة',
//         ),
//         Patient(
//           name: 'فاطمة',
//           age: 5,
//           diagnosis: 'التهاب رئوي',
//           description: 'يعاني من صعوبة في التنفس',
//         ),
//         Patient(
//           name: 'أحمد',
//           age: 8,
//           diagnosis: 'جروح',
//           description: 'يعاني من جروح في الوجه واليدين',
//         ),
//       ];
//     });
//   }
//
//   void _selectPatient(Patient patient) {
//     setState(() {
//       _selectedPatient = patient;
//     });
//   }
//
//   void _admitPatient(Patient patient) {
//     setState(() {
//       patient.status = PatientStatus.admitted;
//       _selectedPatient = null;
//     });
//   }
//
//   void _transferToNursery(Patient patient) {
//     setState(() {
//       patient.status = PatientStatus.nursery;
//       _nurseryPatients.add(patient);
//       _referredPatients.remove(patient);
//       _selectedPatient = null;
//     });
//   }
//
//   void _requestAdditionalXrays(Patient patient) {
//     setState(() {
//       _contentIndex = 4;
//     });
//   }
//
//   // ignore: unused_field
//   final List<String> _departments = [
//     'اسعاف',
//     'مراقب الدوام',
//     'ادمن',
//     'قسم الأطفال',
//     'قسم الهضمية',
//     'قسم العظمية',
//     'قسم النسائية',
//     'قسم الأشعة',
//     'قسم المخابر',
//     'قسم الجراحة',
//     'قسم البولية',
//     'قسم الصدرية',
//     'قسم القلبية',
//     'قسم الجلدية',
//     'قسم الأعصاب',
//
//     // Add other departments here
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _contentIndex = index;
//     });
//   }
//
//   Widget _buildReferredPatientsList() {
//     return ListView.builder(
//       itemCount: _referredPatients.length,
//       itemBuilder: (context, index) {
//         final patient = _referredPatients[index];
//         return ListTile(
//           title: Text(patient.name),
//           subtitle: Text(patient.diagnosis),
//           onTap: () => _selectPatient(patient),
//         );
//       },
//     );
//   }
//
//   Widget _buildNurseryPatientsList() {
//     return ListView.builder(
//       itemCount: _nurseryPatients.length,
//       itemBuilder: (context, index) {
//         final patient = _nurseryPatients[index];
//         return ListTile(
//           title: Text(patient.name),
//           subtitle: Text('العمر: ${patient.age}'),
//           onTap: () => _showPatientDetails(patient),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//             /* image: DecorationImage(
//             image: AssetImage('images/ba.jpg'),
//             fit: BoxFit.cover,
//           ),*/
//             ),
//         child: Row(
//           children: [
//             // NavigationRail
//             Container(
//               //color: Colors.blue,
//               width: 300, // عرض المستطيل
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18.0),
//                 color: Colors.blue, // لون الخلفية أزرق
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//
//                 // إضافة حشوة داخل المستطيل
//                 child: NavigationRail(
//                   minWidth: 72.0,
//                   selectedIndex: _selectedIndex,
//                   onDestinationSelected: _onItemTapped,
//                   labelType: NavigationRailLabelType.all,
//                   backgroundColor: Colors.blue,
//                   destinations: const [
//                     NavigationRailDestination(
//                       icon: Icon(
//                         Icons.home,
//                         color: Colors.white, // لون الأيقونة أبيض
//                       ),
//                       label: Text(
//                         'الصفحة الرئيسية',
//                         style: TextStyle(color: Colors.white), // لون النص أبيض
//                       ),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(
//                         Icons.list,
//                         color: Colors.white, // لون الأيقونة أبيض
//                       ),
//                       label: Text(
//                         'المرضى المقيمين',
//                         style: TextStyle(color: Colors.white), // لون النص أبيض
//                       ),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(
//                         Icons.baby_changing_station,
//                         color: Colors.white, // لون الأيقونة أبيض
//                       ),
//                       label: Text(
//                         'الحاضنة ',
//                         style: TextStyle(color: Colors.white),
//                         // onPressed: () => _transferToNursery(patient), // لون النص أبيض
//                       ),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(
//                         Icons.logout,
//                         color: Colors.white, // لون الأيقونة أبيض
//                       ),
//                       label: Text(
//                         'تسجيل الخروج',
//                         style: TextStyle(color: Colors.white), // لون النص أبيض
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // واجهة المحتوى
//             Expanded(
//                 child: _selectedIndex == 0
//                     ? _buildPatientsList()
//                     : _selectedIndex == 1
//                         ? const AdmittedPatientsPage()
//                         : _selectedIndex == 2
//                             ? NurseryList(
//                                 children: [
//                                   Child(
//                                     name: 'خالد',
//                                     age: 3,
//                                   ),
//                                   Child(
//                                       name: 'لينا',
//                                       age: 1,
//                                       medicalRecord:
//                                           _createMedicalRecord('لينا')),
//                                   Child(
//                                       name: 'سليم',
//                                       age: 5,
//                                       medicalRecord:
//                                           _createMedicalRecord('سليم')),
//                                 ],
//                               )
//                             : LogoutWidget()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   //
//
//   Widget _buildPatientsList() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 50.0),
//       child: ListView.builder(
//         itemCount: _referredPatients.length,
//         itemBuilder: (context, index) {
//           final patient = _referredPatients[index];
//
//           return ListTile(
//             title: Text(patient.name),
//             subtitle: Text('العمر: ${patient.age}'),
//             onTap: () => _showPatientDetails(patient),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: 140,
//                   child: ElevatedButton(
//                     onPressed: () => (Patient patient) {
//                       // Implement the logic to admit the patient
//                     }(patient),
//                     child: const Text('قبول'),
//                   ),
//                 ),
//                 const SizedBox(width: 3.5),
//                 SizedBox(
//                   width: 140,
//                   child: ElevatedButton(
//                     onPressed: () => _requestAdditionalTests(patient),
//                     child: const Text('طلب تحاليل اضافية'),
//                   ),
//                 ),
//                 const SizedBox(width: 3.5),
//                 SizedBox(
//                   width: 140,
//                   child: ElevatedButton(
//                     onPressed: () => _requestXRay(patient),
//                     child: const Text('طلب تصوير اشعة'),
//                   ),
//                 ),
//                 const SizedBox(width: 3.5),
//                 SizedBox(
//                   width: 140,
//                   child: ElevatedButton(
//                     onPressed: () => _transferToIncubator(patient),
//                     child: const Text('تحويل الى الحاضنة'),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _showPatientDetails(Patient patient) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('${patient.name}'),
//         content: Text(
//           'العمر: ${patient.age}\n'
//           'التشخيص: ${patient.diagnosis}\n'
//           'الوصف: ${patient.description}',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('موافق'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _requestAdditionalTests(Patient patient) {
//     // Implement the logic to request additional tests for the patient
//   }
//
//   void _requestXRay(Patient patient) {
//     // Implement the logic to request an X-Ray for the patient
//   }
//
//   void _transferToIncubator(Patient patient) {
//     // Implement the logic to transfer the patient to the incubator
//   }
// }
//
// class LogoutWidget extends StatefulWidget {
//   // final Function onLogoutConfirmed; // Callback for successful logout
//
//   const LogoutWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<LogoutWidget> createState() => _LogoutWidgetState();
// }
//
// class _LogoutWidgetState extends State<LogoutWidget> {
//   final _departments = [
//     'اسعاف',
//     'مراقب الدوام',
//     'ادمن',
//     'قسم الأطفال',
//     'قسم الهضمية',
//     'قسم العظمية',
//     'قسم النسائية',
//     'قسم الأشعة',
//     'قسم المخابر',
//     'قسم الجراحة',
//     'قسم البولية',
//     'قسم الصدرية',
//     'قسم القلبية',
//     'قسم الجلدية',
//     'قسم الأعصاب',
//   ]; // Replace with actual departments
//   String? _selectedDepartment;
//   final _passwordController = TextEditingController();
//   bool _isPasswordIncorrect = false;
//
//   void _handleLogoutPressed() async {
//     // Simulate authentication logic (replace with actual API call or verification)
//     if (_selectedDepartment != null &&
//         _passwordController.text == 'correct_password') {
//       setState(() {
//         _isPasswordIncorrect = false;
//       });
//       //widget.onLogoutConfirmed(); // Call the callback to handle logout actions
//     } else {
//       setState(() {
//         _isPasswordIncorrect = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('الانتقال الى قسم اخر'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           DropdownButtonFormField<String>(
//             value: _selectedDepartment,
//             decoration: InputDecoration(labelText: 'اختر القسم'),
//             items: _departments.map((String department) {
//               return DropdownMenuItem<String>(
//                 value: department,
//                 child: Text(department),
//               );
//             }).toList(),
//             onChanged: (String? newValue) =>
//                 setState(() => _selectedDepartment = newValue),
//             validator: (value) => value == null ? 'يجب اختيار قسم' : null,
//           ),
//           SizedBox(height: 30),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: 'كلمة المرور',
//               errorText: _isPasswordIncorrect ? 'كلمة المرور غير صحيحة' : null,
//             ),
//           ),
//           SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: _handleLogoutPressed,
//             child: Text(' تاكيد'),
//           ),
//         ],
//       ),
//     );
//   }
// }
