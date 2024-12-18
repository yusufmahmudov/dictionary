import 'package:language/assets/constants/storage_keys.dart';
import 'package:language/data/g_model/word_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/word_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';
import 'package:language/infrastructure/repository/storage_repository.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WordService {
  final SupabaseClient supabase = Supabase.instance.client;
  GradeService gradeService = GradeService();

  Future<void> addWords(List<WordModelG> words, GradeModel grade) async {
    try {
      int id = grade.id!;
      int count = grade.count! + words.length;

      final List<Map<String, dynamic>> wordsData =
          words.map((word) => word.toJson()).toList();

      await supabase.from(Tables.word.text).insert(wordsData);

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

  // hamma wordlar
  Future<List<WordModel>> fetchWord() async {
    try {
      int userId = StorageRepository.getInt(StorageKeys.USERID);

      final List<dynamic> response =
          await supabase.from(Tables.word.text).select().eq("users_id", userId);
      return response.map((e) => WordModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  // grade bo'yicha hammasi
  Future<List<WordModel>> fetchWordByGrade(int gradeId) async {
    try {
      final List<dynamic> response = await supabase
          .from(Tables.word.text)
          .select()
          .eq('grade_id', gradeId);
      return response.map((e) => WordModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  // active grade bo'yicha hammasi
  Future<List<WordModel>> fetchWordByActive(bool active) async {
    try {
      final List<int> gradeIds =
          await GradeService().fetchGradeIdByQuery('Words', active);
      String ids = gradeIds.join(",");

      final response = await supabase
          .from(Tables.word.text)
          .select()
          .filter("grade_id", "in", "($ids)");

      return response.map((e) => WordModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> updateWord(WordModel word) async {
    try {
      await supabase
          .from(Tables.word.text)
          .update(word.toJson() as Map)
          .eq('id', word.id!);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> deleteWord(int id) async {
    try {
      await supabase.from(Tables.word.text).delete().eq("id", id);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }
}
