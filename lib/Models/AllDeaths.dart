class AllDeaths {
  int? id;
  String? name;
  String? fatherName;
  String? momName;
  String? birthDate;
  String? city;
  String? nationalId;
  String? deathDate;
  String? deathHour;
  String? reasonOfDeath;
  Null? createdAt;
  Null? updatedAt;

  AllDeaths(
      {this.id,
        this.name,
        this.fatherName,
        this.momName,
        this.birthDate,
        this.city,
        this.nationalId,
        this.deathDate,
        this.deathHour,
        this.reasonOfDeath,
        this.createdAt,
        this.updatedAt});

  AllDeaths.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['father_name'];
    momName = json['mom_name'];
    birthDate = json['birth_date'];
    city = json['city'];
    nationalId = json['National_id'];
    deathDate = json['death_date'];
    deathHour = json['death_hour'];
    reasonOfDeath = json['reason_of_death'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mom_name'] = this.momName;
    data['birth_date'] = this.birthDate;
    data['city'] = this.city;
    data['National_id'] = this.nationalId;
    data['death_date'] = this.deathDate;
    data['death_hour'] = this.deathHour;
    data['reason_of_death'] = this.reasonOfDeath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}