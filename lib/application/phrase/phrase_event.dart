part of 'phrase_bloc.dart';

@immutable
sealed class PhraseEvent {}

class GetPhraseEvent extends PhraseEvent {}

class CreatePhraseEvent extends PhraseEvent {
  final List<PhraseModelG> phrase;
  final GradeModel grade;
  final VoidCallback onSuccess;

  CreatePhraseEvent({
    required this.phrase,
    required this.grade,
    required this.onSuccess,
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
