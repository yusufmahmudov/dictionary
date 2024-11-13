import 'package:language/data/g_model/phrase_model_g.dart';
import 'package:language/data/phrase_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:language/utils/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PhraseService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> addPhrase(PhraseModelG phrase) async {
    try {
      final response = await supabase
          .from(Tables.phrase.text)
          .insert(phrase.toJson())
          .select();
      Log.i(response);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  // hamma phraselar
  Future<List<PhraseModel>> fetchphrase() async {
    try {
      final List<dynamic> response =
          await supabase.from(Tables.phrase.text).select();
      return response.map((e) => PhraseModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  // grade bo'yicha hammasi
  Future<List<PhraseModel>> fetchPhraseByGrade(int gradeId) async {
    try {
      final List<dynamic> response = await supabase
          .from(Tables.phrase.text)
          .select()
          .eq('grade_id', gradeId);
      return response.map((e) => PhraseModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  // active grade bo'yicha hammasi
  Future<List<PhraseModel>> fetchPhraseByActive(bool active) async {
    try {
      final List<int> gradeIds =
          await GradeService().fetchGradeIdByQuery('phrase', active);
      String ids = gradeIds.join(",");

      final response = await supabase
          .from(Tables.phrase.text)
          .select()
          .filter("grade_id", "in", "($ids)");

      return response.map((e) => PhraseModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> updatephrase(PhraseModel phrase) async {
    try {
      await supabase
          .from(Tables.phrase.text)
          .update(phrase.toJson() as Map)
          .eq('id', phrase.id!);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> deletePhrase(int id) async {
    try {
      await supabase.from(Tables.phrase.text).delete().eq("id", id);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }
}
