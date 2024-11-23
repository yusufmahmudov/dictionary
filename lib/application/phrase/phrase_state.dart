part of 'phrase_bloc.dart';

class PhraseState extends Equatable {
  final FormzSubmissionStatus statusPhrase;
  final List<PhraseModel> phrase;
  final int selPhrase;

  const PhraseState({
    this.statusPhrase = FormzSubmissionStatus.initial,
    this.phrase = const [],
    this.selPhrase = -1,
  });

  @override
  List<Object?> get props => [statusPhrase, phrase, selPhrase];

  PhraseState copyWith({
    FormzSubmissionStatus? statusPhrase,
    List<PhraseModel>? phrase,
    int? selPhrase,
  }) {
    return PhraseState(
      statusPhrase: statusPhrase ?? this.statusPhrase,
      phrase: phrase ?? this.phrase,
      selPhrase: selPhrase ?? this.selPhrase,
    );
  }
}
