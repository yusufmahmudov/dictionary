import 'package:language/data/g_model/grade_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/word_model.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GradeService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<GradeModel>> addGrade(GradeModelG grade) async {
    try {
      final result = await supabase
          .from(Tables.grade.text)
          .insert(grade.toJson())
          .select();
      return result.map((e) => GradeModel.fromJson(e)).toList();
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

  Future<List<WordModel>> fetchGradeByIdAll(int id, String category) async {
    try {
      List<dynamic> response = [];
      if (category.compareTo("Words") == 0) {
        response =
            await supabase.from(Tables.word.text).select().eq('grade_id', id);
      } else {
        response =
            await supabase.from(Tables.phrase.text).select().eq("grade_id", id);
      }
      return response.map((e) => WordModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<List<GradeModel>> fetchGradeByCategory(String category) async {
    try {
      List<dynamic> response = [];
      if (category.compareTo("All dictionaries") == 0) {
        final List<dynamic> response = await supabase
            .from(Tables.grade.text)
            .select()
            .or('category.eq.Words,category.eq.Phrases');
        return response.map((e) => GradeModel.fromJson(e)).toList();
      } else if (category.compareTo("Grade") == 0) {
        response = await supabase.from(Tables.grade.text).select();
      } else {
        response = await supabase
            .from(Tables.grade.text)
            .select()
            .eq('category', category);
      }
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

  Future<List<GradeModel>> updateGrade(GradeModel grade) async {
    try {
      final result = await supabase
          .from(Tables.grade.text)
          .update(grade.toJson() as Map)
          .eq('id', grade.id!)
          .select();
      return result.map((e) => GradeModel.fromJson(e)).toList();
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
