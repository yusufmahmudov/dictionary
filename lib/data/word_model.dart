// To parse this JSON data, do
//
//     final wordModel = wordModelFromJson(jsonString);

import 'dart:convert';

WordModel wordModelFromJson(String str) => WordModel.fromJson(json.decode(str));

String wordModelToJson(WordModel data) => json.encode(data.toJson());

class WordModel {
  final int? id;
  final String? uz;
  final String? en;
  final int? gradeId;
  final int? usersId;

  WordModel({
    this.id,
    this.uz,
    this.en,
    this.gradeId,
    this.usersId,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
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
