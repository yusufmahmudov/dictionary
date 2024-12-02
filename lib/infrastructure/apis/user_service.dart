import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

import 'package:language/data/g_model/users_model_g.dart';
import 'package:language/data/login.dart';
import 'package:language/data/register.dart';
import 'package:language/data/users_model.dart';
import 'package:language/utils/enum_filtr.dart';
import 'package:language/utils/generate_random.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Users>> addUser(UserModelG user) async {
    try {
      final response =
          await supabase.from(Tables.user.text).insert(user).select();

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

  Future<Login> checkLogin(Login login) async {
    try {
      final response = await supabase
          .from(Tables.user.text)
          .select()
          .eq("phone", login.phone);

      if (response.isEmpty) {
        login.success = false;
        login.id = -1;
        return login;
      }

      Users user = response.map((e) => Users.fromJson(e)).toList().first;
      String pass = user.password!;
      String saltedText = user.salt! + login.password + user.salt!;

      var bytes = utf8.encode(saltedText);
      var hash = md5.convert(bytes);

      if (hash.toString() == pass) {
        login.success = true;
        login.id = user.id!;
        return login;
      }

      login.success = false;

      return login;
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }

  Future<Register> checkRegister(Register register) async {
    try {
      final response = await supabase
          .from(Tables.user.text)
          .select()
          .eq("phone", register.phone);

      if (response.isNotEmpty) {
        register.success = false;
        register.id = -1;
        return register;
      }

      String salt = generateRandomPassword(16);
      String saltedText = salt + register.password + salt;

      var bytes = utf8.encode(saltedText);
      var hash = md5.convert(bytes);

      UserModelG user = UserModelG(
        name: register.name,
        phone: register.phone,
        salt: salt,
        password: hash.toString(),
      );

      final responseData =
          await supabase.from(Tables.user.text).insert(user).select();

      if (responseData.isEmpty) {
        register.success = false;
        register.id = -2;
        return register;
      }

      Users userData =
          responseData.map((e) => Users.fromJson(e)).toList().first;

      register.success = true;
      register.id = userData.id!;

      return register;
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
