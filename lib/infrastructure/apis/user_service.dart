import 'package:language/data/g_model/users_model_g.dart';
import 'package:language/data/login.dart';
import 'package:language/data/register.dart';
import 'package:language/data/users_model.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Users>> addUser(UserModelG user) async {
    try {
      final response = await supabase.from(Tables.user.text).select();

      return response.map((e) => Users.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }

  Future<List<Users>> allUserData(int id) async {
    try {
      if (id == 1) {
        final List<dynamic> response =
            await supabase.from(Tables.user.text).select();
        return response.map((e) => Users.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }

  Future<List<Users>> fetchUserById(int id) async {
    try {
      final response =
          await supabase.from(Tables.user.text).select().eq("id", id);

      return response.map((e) => Users.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }

  Future<List<Users>> checkLogin(Login login) async {
    try {
      final response = await supabase.from(Tables.user.text).select();

      return response.map((e) => Users.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }

  Future<List<Users>> checkRegister(Register register) async {
    try {
      final response = await supabase.from(Tables.user.text).select();

      return response.map((e) => Users.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }

  Future<void> updateUserDate(Users user) async {
    try {
      await supabase
          .from(Tables.user.text)
          .update(user.toJson())
          .eq("id", user.id!);
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }
}
