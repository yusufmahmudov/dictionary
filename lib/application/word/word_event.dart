part of 'word_bloc.dart';

@immutable
sealed class WordEvent {}

class GetWordsEvent extends WordEvent {}

class GetWordsByGrade extends WordEvent {
  final int gradeId;

  GetWordsByGrade({required this.gradeId});
}

class GetWordsByActive extends WordEvent {
  final bool active;

  GetWordsByActive({required this.active});
}

class CreateWordsEvent extends WordEvent {
  final List<WordModelG> words;
  final GradeModel grade;
  final VoidCallback onSuccess;

  CreateWordsEvent({
    required this.grade,
    required this.words,
    required this.onSuccess,
  });
}
