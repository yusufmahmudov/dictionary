// To parse this JSON data, do
//
//     final principleModelG = principleModelGFromJson(jsonString);

import 'dart:convert';

PrincipleModelG principleModelGFromJson(String str) =>
    PrincipleModelG.fromJson(json.decode(str));

String principleModelGToJson(PrincipleModelG data) =>
    json.encode(data.toJson());

class PrincipleModelG {
  final String? name;
  final String? reference;
  final int? gradeId;
  final int? usersId;

  PrincipleModelG({
    this.name,
    this.reference,
    this.gradeId,
    this.usersId,
  });

  factory PrincipleModelG.fromJson(Map<String, dynamic> json) =>
      PrincipleModelG(
        name: json["name"],
        reference: json["reference"],
        gradeId: json["grade_id"],
        usersId: json["users_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "reference": reference,
        "grade_id": gradeId,
        "users_id": usersId,
      };
}
