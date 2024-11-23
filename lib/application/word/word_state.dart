part of 'word_bloc.dart';

class WordState extends Equatable {
  final FormzSubmissionStatus statusWord;
  final List<WordModel> words;
  final int selWord;

  const WordState({
    this.statusWord = FormzSubmissionStatus.initial,
    this.words = const [],
    this.selWord = -1,
  });

  @override
  List<Object?> get props => [statusWord, words, selWord];

  WordState copyWith({
    FormzSubmissionStatus? statusWord,
    List<WordModel>? words,
    int? selWord,
  }) {
    return WordState(
      statusWord: statusWord ?? this.statusWord,
      words: words ?? this.words,
      selWord: selWord ?? this.selWord,
    );
  }
}
