class CreateDepartment {
  String? name;
  String? password;
  int? id;

  CreateDepartment({this.name, this.password, this.id});

  CreateDepartment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }
}