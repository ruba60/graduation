// class Resedent_pationt {
//   ResidentInformation? residentInformation;
//   String? patientName;

//   Resedent_pationt({this.residentInformation, this.patientName});

//   Resedent_pationt.fromJson(Map<String, dynamic> json) {
//     residentInformation = json['resident information'] != null
//         ? new ResidentInformation.fromJson(json['resident information'])
//         : null;
//     patientName = json[' patient name : '];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.residentInformation != null) {
//       data['resident information'] = this.residentInformation!.toJson();
//     }
//     data[' patient name : '] = this.patientName;
//     return data;
//   }
// }

// class ResidentInformation {
//   int? id;
//   int? departmentId;
//   int? patientId;
//   List<Null>? testResult;
//   List<Null>? xRayResult;
//   String? resident;
//   String? createdAt;
//   String? updatedAt;

//   ResidentInformation(
//       {this.id,
//       this.departmentId,
//       this.patientId,
//       this.testResult,
//       this.xRayResult,
//       this.resident,
//       this.createdAt,
//       this.updatedAt});

//   ResidentInformation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     departmentId = json['department_id'];
//     patientId = json['patient_id'];
//     if (json['test_result'] != null) {
//       testResult = <Null>[];
//       json['test_result'].forEach((v) {
//         // testResult!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['X_ray_result'] != null) {
//       xRayResult = <Null>[];
//       json['X_ray_result'].forEach((v) {
//         // xRayResult!.add(new Null.fromJson(v));
//       });
//     }
//     resident = json['resident'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['department_id'] = this.departmentId;
//     data['patient_id'] = this.patientId;
//     if (this.testResult != null) {
//       //data['test_result'] = this.testResult!.map((v) => v.toJson()).toList();
//     }
//     if (this.xRayResult != null) {
//       //data['X_ray_result'] = this.xRayResult!.map((v) => v.toJson()).toList();
//     }
//     data['resident'] = this.resident;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

class Resedent_pationt {
  int id;
  int departmentId;
  int patientId;
  String testResult;
  String xRayResult;
  String resident;
  DateTime createdAt;
  DateTime updatedAt;
  String patientName;

  Resedent_pationt({
    required this.id,
    required this.departmentId,
    required this.patientId,
    required this.testResult,
    required this.xRayResult,
    required this.resident,
    required this.createdAt,
    required this.updatedAt,
    required this.patientName,
  });

  factory Resedent_pationt.fromJson(Map<String, dynamic> json) {
    return Resedent_pationt(
      id: json['resident information']['id'],
      departmentId: json['resident information']['department_id'],
      patientId: json['resident information']['patient_id'],
      testResult: json['resident information']['test_result'],
      xRayResult: json['resident information']['X_ray_result'],
      resident: json['resident information']['resident'],
      createdAt: json['resident information']['created_at'] != null
          ? DateTime.parse(json['resident information']['created_at'])
          : DateTime.now(),
      updatedAt: json['resident information']['updated_at'] != null
          ? DateTime.parse(json['resident information']['updated_at'])
          : DateTime.now(),
      patientName: json[' patient name : '],
    );
  }
}
