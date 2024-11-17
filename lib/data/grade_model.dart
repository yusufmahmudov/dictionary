// To parse this JSON data, do
//
//     final gradeModel = gradeModelFromJson(jsonString);

import 'dart:convert';

GradeModel gradeModelFromJson(String str) =>
    GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {
  final int? id;
  final String? name;
  final bool? success;
  final String? category;
  final int? count;

  GradeModel({
    this.id,
    this.name,
    this.success,
    this.category,
    this.count,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
        id: json["id"],
        name: json["name"],
        success: json["success"],
        category: json["category"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "success": success,
        "category": category,
        "count": count,
      };
}
