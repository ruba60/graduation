class Surgery_model {
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

  Surgery_model(
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

  Surgery_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['patient']['full_name'];
    address = json['patient']['address'];
    dateOfBirth = json['patient']['date_of_birth'];
    momName = json['patient']['mom_name'];
    chain = json['patient']['chain'];
    gender = json['patient']['gender'];
    caseDescription = json['patient']['case_description'];
    treatmentRequired = json['patient']['treatment_required'];
    createdAt = json['patient']['created_at'];
    updatedAt = json['patient']['updated_at'];
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
