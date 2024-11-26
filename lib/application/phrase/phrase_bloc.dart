import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/data/g_model/phrase_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/phrase_model.dart';
import 'package:language/infrastructure/apis/phrase_service.dart';

part 'phrase_event.dart';
part 'phrase_state.dart';

class PhraseBloc extends Bloc<PhraseEvent, PhraseState> {
  PhraseBloc() : super(const PhraseState()) {
    on<GetPhraseEvent>(
      (event, emit) async {
        emit(state.copyWith(statusPhrase: FormzSubmissionStatus.inProgress));
        final result = await PhraseService().fetchphrase();
        emit(
          state.copyWith(
            statusPhrase: FormzSubmissionStatus.success,
            phrase: result,
          ),
        );
      },
    );

    on<GetPhraseByGrade>(
      (event, emit) async {
        emit(state.copyWith(statusPhrase: FormzSubmissionStatus.inProgress));
        final result = await PhraseService().fetchPhraseByGrade(event.gradeId);
        emit(
          state.copyWith(
            statusPhrase: FormzSubmissionStatus.success,
            phrase: result,
          ),
        );
      },
    );

    on<GetPhraseByActive>(
      (event, emit) async {
        emit(state.copyWith(statusPhrase: FormzSubmissionStatus.inProgress));
        final result = await PhraseService().fetchPhraseByActive(event.active);
        emit(
          state.copyWith(
            statusPhrase: FormzSubmissionStatus.success,
            phrase: result,
          ),
        );
      },
    );

    on<CreatePhraseEvent>(
      (event, emit) async {
        state.copyWith(statusPhrase: FormzSubmissionStatus.inProgress);
        try {
          await PhraseService().addPhrase(event.phrase, event.grade);
          emit(state.copyWith(statusPhrase: FormzSubmissionStatus.success));
          event.onSuccess();
          add(GetPhraseEvent());
        } catch (e) {
          e.toString();
          state.copyWith(statusPhrase: FormzSubmissionStatus.failure);
        }
      },
    );
  }
}
