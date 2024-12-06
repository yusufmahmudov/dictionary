import 'package:language/assets/constants/storage_keys.dart';
import 'package:language/data/g_model/principle_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/principle_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';
import 'package:language/infrastructure/repository/storage_repository.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PrincipleService {
  final SupabaseClient supabase = Supabase.instance.client;
  GradeService gradeService = GradeService();

  Future<void> addPrinciple(
      List<PrincipleModelG> principles, GradeModel grade) async {
    try {
      int id = grade.id!;
      int count = grade.count! + principles.length;

      final List<Map<String, dynamic>> principleData =
          principles.map((prin) => prin.toJson()).toList();

      await supabase.from(Tables.principle.text).insert(principleData);

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

  // hamma principlelar
  Future<List<PrincipleModel>> fetchPrinciple() async {
    try {
      int userId = StorageRepository.getInt(StorageKeys.USERID);

      final List<dynamic> response = await supabase
          .from(Tables.principle.text)
          .select()
          .eq("users_id", userId);
      return response.map((e) => PrincipleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  // grade bo'yicha hammasi
  Future<List<PrincipleModel>> fetchPrincipleByGrade(int gradeId) async {
    try {
      final List<dynamic> response = await supabase
          .from(Tables.principle.text)
          .select()
          .eq('grade_id', gradeId);
      return response.map((e) => PrincipleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  // active grade bo'yicha hammasi
  Future<List<PrincipleModel>> fetchPrincipleByActive(bool active) async {
    try {
      final List<int> gradeIds =
          await GradeService().fetchGradeIdByQuery('principle', active);
      String ids = gradeIds.join(",");

      final response = await supabase
          .from(Tables.principle.text)
          .select()
          .filter("grade_id", "in", "($ids)");

      return response.map((e) => PrincipleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> updatePrinciple(PrincipleModel principle) async {
    try {
      await supabase
          .from(Tables.principle.text)
          .update(principle.toJson() as Map)
          .eq('id', principle.id!);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  Future<void> deletePrinciple(int id) async {
    try {
      await supabase.from(Tables.principle.text).delete().eq("id", id);
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }
}
