import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/data/g_model/grade_model_g.dart';
import 'package:equatable/equatable.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/word_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';

part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  GradeBloc() : super(const GradeState()) {
    on<GetGradeEvent>(
      (event, emit) async {
        emit(state.copyWith(statusGrade: FormzSubmissionStatus.inProgress));
        final result = await GradeService().fetchGrade();
        emit(
          state.copyWith(
            statusGrade: FormzSubmissionStatus.success,
            grade: result,
          ),
        );
      },
    );

    on<GetWordsByGradeId>(
      (event, emit) async {
        emit(state.copyWith(statusGrade: FormzSubmissionStatus.inProgress));
        final result =
            await GradeService().fetchGradeByIdAll(event.id, event.category);
        emit(
          state.copyWith(
            statusGrade: FormzSubmissionStatus.success,
            words: result,
          ),
        );
      },
    );

    on<GetGradeByCategory>(
      (event, emit) async {
        emit(state.copyWith(statusGrade: FormzSubmissionStatus.inProgress));
        final result =
            await GradeService().fetchGradeByCategory(event.category);
        emit(
          state.copyWith(
            statusGrade: FormzSubmissionStatus.success,
            grade: result,
          ),
        );
      },
    );

    on<CreateGradeEvent>(
      (event, emit) async {
        state.copyWith(statusGrade: FormzSubmissionStatus.inProgress);
        try {
          await GradeService().addGrade(event.grade);

          state.copyWith(statusGrade: FormzSubmissionStatus.success);
          add(GetGradeEvent());
        } catch (e) {
          event.onError(
            e.toString(),
          );
          state.copyWith(statusGrade: FormzSubmissionStatus.failure);
        }
      },
    );

    on<UpdateGradeEvent>(
      (event, emit) async {
        emit(state.copyWith(statusGrade: FormzSubmissionStatus.inProgress));
        try {
          await GradeService().updateGrade(event.grade);
          state.copyWith(statusGrade: FormzSubmissionStatus.success);
          add(GetGradeEvent());
        } catch (e) {
          state.copyWith(statusGrade: FormzSubmissionStatus.failure);
        }
      },
    );

    on<SelGradeEvent>(
      (event, emit) {
        emit(state.copyWith(selGrade: event.index));
      },
    );
  }
}
