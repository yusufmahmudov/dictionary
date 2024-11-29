// To parse this JSON data, do
//
//     final phraseModel = phraseModelFromJson(jsonString);

import 'dart:convert';

PhraseModel phraseModelFromJson(String str) =>
    PhraseModel.fromJson(json.decode(str));

String phraseModelToJson(PhraseModel data) => json.encode(data.toJson());

class PhraseModel {
  final int? id;
  final String? uz;
  final String? en;
  final int? gradeId;
  final int? usersId;

  PhraseModel({
    this.id,
    this.uz,
    this.en,
    this.gradeId,
    this.usersId,
  });

  factory PhraseModel.fromJson(Map<String, dynamic> json) => PhraseModel(
        id: json["id"],
        uz: json["uz"],
        en: json["en"],
        gradeId: json["grade_id"],
        usersId: json["users_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uz": uz,
        "en": en,
        "grade_id": gradeId,
        "users_id": usersId,
      };
}
