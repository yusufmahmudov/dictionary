// To parse this JSON data, do
//
//     final wordModelG = wordModelGFromJson(jsonString);

import 'dart:convert';

WordModelG wordModelGFromJson(String str) =>
    WordModelG.fromJson(json.decode(str));

String wordModelGToJson(WordModelG data) => json.encode(data.toJson());

class WordModelG {
  final String? uz;
  final String? en;
  final int? gradeId;
  final int? usersId;

  WordModelG({
    this.uz,
    this.en,
    this.gradeId,
    this.usersId,
  });

  factory WordModelG.fromJson(Map<String, dynamic> json) => WordModelG(
        uz: json["uz"],
        en: json["en"],
        gradeId: json["grade_id"],
        usersId: json["users_id"],
      );

  Map<String, dynamic> toJson() => {
        "uz": uz,
        "en": en,
        "grade_id": gradeId,
        "users_id": usersId,
      };
}
