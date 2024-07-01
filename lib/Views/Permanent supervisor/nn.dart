import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For printing

class PatientRecordPage extends StatefulWidget {
  final String patientName;
  final Map<String, dynamic> patientData;

  const PatientRecordPage({
    Key? key,
    required this.patientName,
    required this.patientData,
  }) : super(key: key);

  @override
  _PatientRecordPageState createState() => _PatientRecordPageState();
}

class _PatientRecordPageState extends State<PatientRecordPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _printRecord() async {
    // TODO: Implement printing logic to generate and print the patient record
    // For example, you could use a third-party printing library or platform-specific APIs

    // Show a snackbar to indicate printing status
    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
      ..showSnackBar(SnackBar(
        content: Text('Printing patient record...'),
      ));

    // Simulate printing delay
    await Future.delayed(Duration(seconds: 2));

    // Show a success snackbar
    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
      ..showSnackBar(SnackBar(
        content: Text('Patient record printed successfully!'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Patient Record: ${widget.patientName}'),
        actions: [
          IconButton(
            onPressed: _printRecord,
            icon: Icon(Icons.print),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient Information section
              Text(
                'Patient Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              _buildPatientInfoRow('Full Name:', widget.patientName),
              _buildPatientInfoRow(
                  'Date of Birth:', widget.patientData['dateOfBirth']),
              _buildPatientInfoRow('Gender:', widget.patientData['gender']),
              _buildPatientInfoRow(
                  'Blood Type:', widget.patientData['bloodType']),

              // Medical History section
              SizedBox(height: 20),
              Text(
                'Medical History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              // Add code to display medical history details from patientData

              // Allergies section
              SizedBox(height: 20),
              Text(
                'Allergies',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              // Add code to display allergies from patientData

              // Medications section
              SizedBox(height: 20),
              Text(
                'Medications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              // Add code to display medications from patientData
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(value),
      ],
    );
  }
}
