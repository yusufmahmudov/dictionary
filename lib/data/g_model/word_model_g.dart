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

  WordModelG({
    this.uz,
    this.en,
    this.gradeId,
  });

  factory WordModelG.fromJson(Map<String, dynamic> json) => WordModelG(
        uz: json["uz"],
        en: json["en"],
        gradeId: json["gradeId"],
      );

  Map<String, dynamic> toJson() => {
        "uz": uz,
        "en": en,
        "gradeId": gradeId,
      };
}
