class Surgery_Amb {
  int? id;
  int? patientId;
  String? createdAt;
  String? updatedAt;
  Null? patient;

  Surgery_Amb(
      {this.id, this.patientId, this.createdAt, this.updatedAt, this.patient});

  Surgery_Amb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['patient'] = this.patient;
    return data;
  }
}
