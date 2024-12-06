import 'package:language/assets/constants/storage_keys.dart';
import 'package:language/data/g_model/phrase_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/phrase_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';
import 'package:language/infrastructure/repository/storage_repository.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PhraseService {
  final SupabaseClient supabase = Supabase.instance.client;
  GradeService gradeService = GradeService();

  Future<void> addPhrase(List<PhraseModelG> phrase, GradeModel grade) async {
    try {
      int id = grade.id!;
      int count = grade.count! + phrase.length;

      final List<Map<String, dynamic>> phraseData =
          phrase.map((p) => p.toJson()).toList();

      await supabase.from(Tables.phrase.text).insert(phraseData);

      await gradeService.updateGrade(
        GradeModel(
          id: id,
          count: count,
          category: grade.category,
          success: grade.success,
          name: grade.name,
          usersId: grade.usersId,
        ),
      );
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  // hamma phraselar
  Future<List<PhraseModel>> fetchphrase() async {
    try {
      int userId = StorageRepository.getInt(StorageKeys.USERID);

      final List<dynamic> response = await supabase
          .from(Tables.phrase.text)
          .select()
          .eq("users_id", userId);
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
          await GradeService().fetchGradeIdByQuery('Phrases', active);
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
