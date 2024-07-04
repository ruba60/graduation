class ResidentPatientModel {
  Information? information;
  String? residentPatient;

  ResidentPatientModel({this.information, this.residentPatient});

  ResidentPatientModel.fromJson(Map<String, dynamic> json) {
    information = json['information '] != null
        ? new Information.fromJson(json['information '])
        : null;
    residentPatient = json[' resident patient '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.information != null) {
      data['information '] = this.information!.toJson();
    }
    data[' resident patient '] = this.residentPatient;
    return data;
  }
}

class Information {
  int? id;
  int? departmentId;
  int? patientId;
  List<Null>? testResult;
  List<Null>? xRayResult;
  String? resident;
  String? createdAt;
  String? updatedAt;

  Information(
      {this.id,
        this.departmentId,
        this.patientId,
        this.testResult,
        this.xRayResult,
        this.resident,
        this.createdAt,
        this.updatedAt});

  Information.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    patientId = json['patient_id'];
    if (json['test_result'] != null) {
      testResult = <Null>[];
      json['test_result'].forEach((v) {
       // testResult!.add(new Null.fromJson(v));
      });
    }
    if (json['X_ray_result'] != null) {
      xRayResult = <Null>[];
      json['X_ray_result'].forEach((v) {
      //  xRayResult!.add(new Null.fromJson(v));
      });
    }
    resident = json['resident'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_id'] = this.departmentId;
    data['patient_id'] = this.patientId;
    if (this.testResult != null) {
    //  data['test_result'] = this.testResult!.map((v) => v.toJson()).toList();
    }
    if (this.xRayResult != null) {
     // data['X_ray_result'] = this.xRayResult!.map((v) => v.toJson()).toList();
    }
    data['resident'] = this.resident;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
