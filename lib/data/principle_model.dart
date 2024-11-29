// To parse this JSON data, do
//
//     final principleModel = principleModelFromJson(jsonString);

import 'dart:convert';

PrincipleModel principleModelFromJson(String str) =>
    PrincipleModel.fromJson(json.decode(str));

String principleModelToJson(PrincipleModel data) => json.encode(data.toJson());

class PrincipleModel {
  final int? id;
  final String? name;
  final String? reference;
  final int? gradeId;
  final int? usersId;

  PrincipleModel({
    this.id,
    this.name,
    this.reference,
    this.gradeId,
    this.usersId,
  });

  factory PrincipleModel.fromJson(Map<String, dynamic> json) => PrincipleModel(
        id: json["id"],
        name: json["name"],
        reference: json["reference"],
        gradeId: json["grade_id"],
        usersId: json["users_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reference": reference,
        "grade_id": gradeId,
        "users_id": usersId,
      };
}
