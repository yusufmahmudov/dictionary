// To parse this JSON data, do
//
//     final phraseModelG = phraseModelGFromJson(jsonString);

import 'dart:convert';

PhraseModelG phraseModelGFromJson(String str) =>
    PhraseModelG.fromJson(json.decode(str));

String phraseModelGToJson(PhraseModelG data) => json.encode(data.toJson());

class PhraseModelG {
  final String? uz;
  final String? en;
  final int? gradeId;
  final int? usersId;

  PhraseModelG({
    this.uz,
    this.en,
    this.gradeId,
    this.usersId,
  });

  factory PhraseModelG.fromJson(Map<String, dynamic> json) => PhraseModelG(
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
