import 'package:flutter/material.dart';

class AddPatient {
  int? id;
  String? full_name;
  String? address;
  String? mom_name;
  int? chain;
  String? gender;
  String? date_of_birth;
  String? case_description;
  String? treatment_required;

  AddPatient({this.id,
    this.full_name,
  this.address,
  this.mom_name,
  this.chain,
  this.gender,
  this.date_of_birth,
  this.case_description,
  this.treatment_required});

  AddPatient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    full_name = json['full_name'];
    address = json['address'];
    mom_name = json['mom_name'];
    chain = json['chain'];
    gender = json['gender'];
    date_of_birth = json['date_of_birth'];
    case_description = json['case_description'];
    treatment_required = json['treatment_required'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.full_name;
    data['address'] = this.address;
    data['mom_name'] = this.mom_name;
    data['chain'] = this.chain;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.date_of_birth;
    data['case_description'] = this.case_description;
    data['treatment_required'] = this.treatment_required;
    return data;
  }


}
