class PatientModel {
  int? patientId;
  String? patientName;

  PatientModel({this.patientId, this.patientName});

  PatientModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    return data;
  }
}