// To parse this JSON data, do
//
//     final gradeModelG = gradeModelGFromJson(jsonString);

import 'dart:convert';

GradeModelG gradeModelGFromJson(String str) =>
    GradeModelG.fromJson(json.decode(str));

String gradeModelGToJson(GradeModelG data) => json.encode(data.toJson());

class GradeModelG {
  final String? name;
  final bool? success;
  final String? category;
  final int? count;

  GradeModelG({
    this.name,
    this.success,
    this.category,
    this.count,
  });

  factory GradeModelG.fromJson(Map<String, dynamic> json) => GradeModelG(
        name: json["name"],
        success: json["success"],
        category: json["category"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "success": success,
        "category": category,
        "count": count,
      };
}
