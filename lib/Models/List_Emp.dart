class List_Emp {
  int? id;
  String? name;
  int? departmentId;
  String? createdAt;
  String? updatedAt;

  List_Emp(
      {this.id, this.name, this.departmentId, this.createdAt, this.updatedAt});

  List_Emp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    departmentId = json['department_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['department_id'] = this.departmentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
