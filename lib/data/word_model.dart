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

  WordModel({
    this.id,
    this.uz,
    this.en,
    this.gradeId,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        id: json["id"],
        uz: json["uz"],
        en: json["en"],
        gradeId: json["gradeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uz": uz,
        "en": en,
        "gradeId": gradeId,
      };
}
