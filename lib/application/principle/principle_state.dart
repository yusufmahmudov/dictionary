part of 'principle_bloc.dart';

class PrincipleState extends Equatable {
  final FormzSubmissionStatus statusPrinciple;
  final List<PrincipleModel> principle;
  final int selPrinciple;

  const PrincipleState({
    this.statusPrinciple = FormzSubmissionStatus.initial,
    this.principle = const [],
    this.selPrinciple = -1,
  });

  @override
  List<Object?> get props => [selPrinciple, statusPrinciple, principle];

  PrincipleState copyWith({
    FormzSubmissionStatus? statusPrinciple,
    List<PrincipleModel>? principle,
    int? selPrinciple,
  }) {
    return PrincipleState(
      selPrinciple: selPrinciple ?? this.selPrinciple,
      statusPrinciple: statusPrinciple ?? this.statusPrinciple,
      principle: principle ?? this.principle,
    );
  }
}
