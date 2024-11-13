import 'package:language/data/g_model/grade_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:language/utils/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GradeService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> addGrade(GradeModelG grade) async {
    try {
      final response = await supabase
          .from(Tables.grade.text)
          .insert(grade.toJson())
          .select();
      Log.i(response);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<List<GradeModel>> fetchGrade() async {
    try {
      final List<dynamic> response =
          await supabase.from(Tables.grade.text).select();
      return response.map((e) => GradeModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<List<GradeModel>> fetchGradeByCategory(String category) async {
    try {
      final List<dynamic> response = await supabase
          .from(Tables.grade.text)
          .select()
          .eq('category', category);
      return response.map((e) => GradeModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<List<int>> fetchGradeIdByQuery(String category, bool active) async {
    try {
      final List<dynamic> response = await supabase
          .from(Tables.grade.text)
          .select('id')
          .eq('category', category)
          .eq('success', active);
      return response.map((e) => e['id'] as int).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> updateGrade(GradeModel grade) async {
    try {
      await supabase
          .from(Tables.grade.text)
          .update(grade.toJson() as Map)
          .eq('id', grade.id!);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> deleteGrade(int id) async {
    try {
      await supabase.from(Tables.grade.text).delete().eq("id", id);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }
}

/**
 
 Future<List<Map<String, dynamic>>> getRandomUsers() async {
  try {
    final response = await supabase
        .from('user')
        .select()
        .order('RANDOM()', foreignTable: null)  // Ma'lumotlarni tasodifiy tartibda oladi
        .limit(20);                             // Faqat 20 ta yozuvni oladi

    return response;
  } catch (e) {
    Log.e("Error fetching random users: $e");
    return [];
  }
}
 */