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

  PhraseModelG({
    this.uz,
    this.en,
    this.gradeId,
  });

  factory PhraseModelG.fromJson(Map<String, dynamic> json) => PhraseModelG(
        uz: json["uz"],
        en: json["en"],
        gradeId: json["grade_id"],
      );

  Map<String, dynamic> toJson() => {
        "uz": uz,
        "en": en,
        "grade_id": gradeId,
      };
}
