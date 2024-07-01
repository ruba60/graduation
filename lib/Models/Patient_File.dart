class PatientFile {
  PatientInformation? patientInfo;
  String? dep;
  String? lastDepartment;
  OtherInformation? other;

  PatientFile({this.patientInfo, this.dep, this.lastDepartment, this.other});

  PatientFile.fromJson(Map<String, dynamic> json) {
    patientInfo = json['patient_info : '] != null
        ? new PatientInformation.fromJson(json['patient_info : '])
        : null;
    dep = json['dep'];
    lastDepartment = json['last_department'];
    other = json['other:'] != null ? new OtherInformation.fromJson(json['other:']) : null;
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

class PatientInformation {
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

  PatientInformation(
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

  PatientInformation.fromJson(Map<String, dynamic> json) {
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

class OtherInformation {
  int? id;
  int? departmentId;
  int? patientId;
  List<Null>? testResult;
  List<Null>? xRayResult;
  String? resident;
  String? createdAt;
  String? updatedAt;

  OtherInformation(
      {this.id,
        this.departmentId,
        this.patientId,
        this.testResult,
        this.xRayResult,
        this.resident,
        this.createdAt,
        this.updatedAt});

  OtherInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    patientId = json['patient_id'];
    // if (json['test_result'] != null) {
    //   testResult = <Null>[];
    //   json['test_result'].forEach((v) {
    //     testResult!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['X_ray_result'] != null) {
    //   xRayResult = <Null>[];
    //   json['X_ray_result'].forEach((v) {
    //     xRayResult!.add(new Null.fromJson(v));
    //   });
    // }
    resident = json['resident'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_id'] = this.departmentId;
    data['patient_id'] = this.patientId;
    // if (this.testResult != null) {
    //   data['test_result'] = this.testResult!.map((v) => v.toJson()).toList();
    // }
    // if (this.xRayResult != null) {
    //   data['X_ray_result'] = this.xRayResult!.map((v) => v.toJson()).toList();
    // }
    data['resident'] = this.resident;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}