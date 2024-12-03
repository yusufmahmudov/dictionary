import 'package:flutter/material.dart';
import 'package:language/app.dart';
import 'package:language/infrastructure/repository/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://cwukwhjhyvkkacifnxcq.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN3dWt3aGpoeXZra2FjaWZueGNxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEzMjQ5NzksImV4cCI6MjA0NjkwMDk3OX0.-gMM9epLr6anjCdQUY3xE_rFG4GYV3UsEOKD3T5pFvU"
      // url: SUPABASE_URL,
      // anonKey: SUPABASE_ANON_KEY,
      );

  await StorageRepository.getInstance();

  runApp(const AppView());
}
