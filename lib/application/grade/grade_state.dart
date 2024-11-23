part of 'grade_bloc.dart';

class GradeState extends Equatable {
  final FormzSubmissionStatus statusGrade;
  final List<GradeModel> grade;
  final List<WordModel> words;
  final int selGrade;

  const GradeState({
    this.statusGrade = FormzSubmissionStatus.initial,
    this.grade = const [],
    this.words = const [],
    this.selGrade = -1,
  });

  @override
  List<Object?> get props => [statusGrade, grade, selGrade, words];

  GradeState copyWith({
    FormzSubmissionStatus? statusGrade,
    List<GradeModel>? grade,
    List<WordModel>? words,
    int? selGrade,
  }) {
    return GradeState(
      statusGrade: statusGrade ?? this.statusGrade,
      grade: grade ?? this.grade,
      selGrade: selGrade ?? this.selGrade,
      words: words ?? this.words,
    );
  }
}
