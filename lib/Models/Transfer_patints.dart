class Pationt_Tr {
  int? id;
  int? patientId;
  String? patientName;
  int? fromDepId;
  String? fromDepName;
  int? toDepId;
  String? toDepName;

  Pationt_Tr(
      {this.id,
      this.patientId,
      this.patientName,
      this.fromDepId,
      this.fromDepName,
      this.toDepId,
      this.toDepName});

  Pationt_Tr.fromJson(Map<String, dynamic> json) {
    id = json['id '];
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    fromDepId = json['from_dep_id'];
    fromDepName = json['from_dep_name'];
    toDepId = json['to_dep_id'];
    toDepName = json['to_dep_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id '] = this.id;
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['from_dep_id'] = this.fromDepId;
    data['from_dep_name'] = this.fromDepName;
    data['to_dep_id'] = this.toDepId;
    data['to_dep_name'] = this.toDepName;
    return data;
  }
}
