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

  PrincipleModelG({
    this.name,
    this.reference,
    this.gradeId,
  });

  factory PrincipleModelG.fromJson(Map<String, dynamic> json) =>
      PrincipleModelG(
        name: json["name"],
        reference: json["reference"],
        gradeId: json["grade_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "reference": reference,
        "grade_id": gradeId,
      };
}
