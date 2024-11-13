import 'package:language/utils/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApisContact {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> delete({required String table, required int id}) async {
    try {
      final response = await supabase.from(table).delete().eq("id", id);
      Log.i(response);
    } catch (e) {
      Log.e("Delete Error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await supabase.from(table).insert(data).select();
      Log.i(response);
      return response;
    } catch (e) {
      Log.e("Insert Error: $e");
      return [];
    }
  }

  Future<void> update({
    required String table,
    required Map<String, dynamic> data,
    required int id,
  }) async {
    try {
      final response = await supabase.from(table).update(data).eq("id", id);
      Log.i(response);
    } catch (e) {
      Log.e("Update Error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> get({required String table}) async {
    try {
      final response = await supabase.from(table).select();
      return response;
    } catch (e) {
      Log.e("Get Error: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getID({
    required String table,
    required String filterName,
    required int id,
    String query = "*",
  }) async {
    try {
      final response =
          await supabase.from(table).select(query).eq(filterName, id);
      Log.i(response);
      return response;
    } catch (e) {
      Log.e("GetID Error: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getQuery({
    required String table,
    required String query,
  }) async {
    try {
      final response = await supabase.from(table).select(query);
      return response;
    } catch (e) {
      Log.e("GetQuery Error: $e");
      return [];
    }
  }
}
