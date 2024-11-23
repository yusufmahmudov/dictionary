part of 'grade_bloc.dart';

@immutable
sealed class GradeEvent {}

class GetGradeEvent extends GradeEvent {}

class GetWordsByGradeId extends GradeEvent {
  final int id;
  final String category;

  GetWordsByGradeId({
    required this.id,
    required this.category,
  });
}

class GetGradeByCategory extends GradeEvent {
  final String category;

  GetGradeByCategory({required this.category});
}

class CreateGradeEvent extends GradeEvent {
  final GradeModelG grade;
  final VoidCallback onSuccess;
  final Function(String name) onError;

  CreateGradeEvent({
    required this.grade,
    required this.onSuccess,
    required this.onError,
  });
}

class UpdateGradeEvent extends GradeEvent {
  final GradeModel grade;
  final VoidCallback onSuccess;

  UpdateGradeEvent({
    required this.grade,
    required this.onSuccess,
  });
}

class SelGradeEvent extends GradeEvent {
  final int index;

  SelGradeEvent({required this.index});
}
