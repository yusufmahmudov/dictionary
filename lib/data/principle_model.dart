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

  PrincipleModel({
    this.id,
    this.name,
    this.reference,
    this.gradeId,
  });

  factory PrincipleModel.fromJson(Map<String, dynamic> json) => PrincipleModel(
        id: json["id"],
        name: json["name"],
        reference: json["reference"],
        gradeId: json["gradeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reference": reference,
        "gradeId": gradeId,
      };
}
