class AllBirths {
  int? id;
  String? name;
  String? fatherName;
  String? motherName;
  String? birthDate;
  String? city;
  String? nationalId;


  AllBirths(
      {this.id,
        this.name,
        this.fatherName,
        this.motherName,
        this.birthDate,
        this.city,
        this.nationalId,
      });

  AllBirths.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    birthDate = json['birth_date'];
    city = json['city'];
    nationalId = json['national_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['birth_date'] = this.birthDate;
    data['city'] = this.city;
    data['national_id'] = this.nationalId;

    return data;
  }
}