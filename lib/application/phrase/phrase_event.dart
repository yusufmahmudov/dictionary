part of 'phrase_bloc.dart';

@immutable
sealed class PhraseEvent {}

class GetPhraseEvent extends PhraseEvent {}

class CreatePhraseEvent extends PhraseEvent {
  final List<PhraseModel> words;
  final GradeModel grade;
  final VoidCallback onSuccess;
  final Function(String name) onError;

  CreatePhraseEvent({
    required this.words,
    required this.grade,
    required this.onSuccess,
    required this.onError,
  });
}

class GetPhraseByGrade extends PhraseEvent {
  final int gradeId;

  GetPhraseByGrade({required this.gradeId});
}

class GetPhraseByActive extends PhraseEvent {
  final bool active;

  GetPhraseByActive({required this.active});
}
