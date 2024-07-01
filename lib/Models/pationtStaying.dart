class PatientInfo {
  PatientInfo? patientInfo;
  String? dep;
  String? lastDepartment;
  Other? other;

  PatientInfo({this.patientInfo, this.dep, this.lastDepartment, this.other});

  PatientInfo.fromJson(Map<String, dynamic> json) {
    patientInfo = json['patient_info : '] != null
        ? new PatientInfo.fromJson(json['patient_info : '])
        : null;
    dep = json['dep'];
    lastDepartment = json['last_department'];
    other = json['other:'] != null ? new Other.fromJson(json['other:']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientInfo != null) {
      data['patient_info : '] = this.patientInfo!.toJson();
    }
    data['dep'] = this.dep;
    data['last_department'] = this.lastDepartment;
    if (this.other != null) {
      data['other:'] = this.other!.toJson();
    }
    return data;
  }
}

class Info {
  int? id;
  String? fullName;
  String? address;
  String? dateOfBirth;
  String? momName;
  int? chain;
  String? gender;
  String? caseDescription;
  String? treatmentRequired;
  String? createdAt;
  String? updatedAt;

  Info(
      {this.id,
      this.fullName,
      this.address,
      this.dateOfBirth,
      this.momName,
      this.chain,
      this.gender,
      this.caseDescription,
      this.treatmentRequired,
      this.createdAt,
      this.updatedAt});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    momName = json['mom_name'];
    chain = json['chain'];
    gender = json['gender'];
    caseDescription = json['case_description'];
    treatmentRequired = json['treatment_required'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['address'] = this.address;
    data['date_of_birth'] = this.dateOfBirth;
    data['mom_name'] = this.momName;
    data['chain'] = this.chain;
    data['gender'] = this.gender;
    data['case_description'] = this.caseDescription;
    data['treatment_required'] = this.treatmentRequired;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Other {
  int? id;
  int? departmentId;
  int? patientId;
  Null? testResult;
  Null? xRayResult;
  String? resident;
  String? createdAt;
  String? updatedAt;

  Other(
      {this.id,
      this.departmentId,
      this.patientId,
      this.testResult,
      this.xRayResult,
      this.resident,
      this.createdAt,
      this.updatedAt});

  Other.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    patientId = json['patient_id'];
    testResult = json['test_result'];
    xRayResult = json['X_ray_result'];
    resident = json['resident'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_id'] = this.departmentId;
    data['patient_id'] = this.patientId;
    data['test_result'] = this.testResult;
    data['X_ray_result'] = this.xRayResult;
    data['resident'] = this.resident;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
