part of 'principle_bloc.dart';

@immutable
sealed class PrincipleEvent {}

class GetPrincipleEvent extends PrincipleEvent {}

class GetPrincipleByGrade extends PrincipleEvent {
  final int gradeId;

  GetPrincipleByGrade({required this.gradeId});
}

class CreatePrincipleEvent extends PrincipleEvent {
  final List<PrincipleModelG> principle;
  final GradeModel grade;
  final VoidCallback onSuccess;

  CreatePrincipleEvent({
    required this.onSuccess,
    required this.principle,
    required this.grade,
  });
}

class SelPrincipleEvent extends PrincipleEvent {
  final int index;

  SelPrincipleEvent({required this.index});
}
