import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/data/g_model/word_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/word_model.dart';
import 'package:language/infrastructure/apis/word_service.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc() : super(const WordState()) {
    on<GetWordsEvent>(
      (event, emit) async {
        emit(state.copyWith(statusWord: FormzSubmissionStatus.inProgress));
        final result = await WordService().fetchWord();
        emit(
          state.copyWith(
            statusWord: FormzSubmissionStatus.success,
            words: result,
          ),
        );
      },
    );

    on<GetWordsByGrade>(
      (event, emit) async {
        emit(state.copyWith(statusWord: FormzSubmissionStatus.inProgress));
        final result = await WordService().fetchWordByGrade(event.gradeId);
        emit(state.copyWith(
          statusWord: FormzSubmissionStatus.success,
          words: result,
        ));
      },
    );

    on<GetWordsByActive>(
      (event, emit) async {
        emit(state.copyWith(statusWord: FormzSubmissionStatus.inProgress));
        final result = await WordService().fetchWordByActive(event.active);
        emit(state.copyWith(
          statusWord: FormzSubmissionStatus.success,
          words: result,
        ));
      },
    );

    on<CreateWordsEvent>(
      (event, emit) async {
        state.copyWith(statusWord: FormzSubmissionStatus.inProgress);
        try {
          await WordService().addWords(event.words, event.grade);

          emit(state.copyWith(statusWord: FormzSubmissionStatus.success));
          add(GetWordsEvent());
        } catch (e) {
          e.toString();
          state.copyWith(statusWord: FormzSubmissionStatus.failure);
        }
      },
    );
  }
}
