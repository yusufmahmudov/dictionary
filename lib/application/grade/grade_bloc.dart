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
          final result = await GradeService().addGrade(event.grade);
          List<GradeModel> list = List.from(state.grade);
          list.addAll(result);

          emit(state.copyWith(
            statusGrade: FormzSubmissionStatus.success,
            grade: list,
          ));
          event.onSuccess();
          add(GetGradeEvent());
        } catch (e) {
          e.toString();
          state.copyWith(statusGrade: FormzSubmissionStatus.failure);
        }
      },
    );

    on<UpdateGradeEvent>(
      (event, emit) async {
        emit(state.copyWith(statusGrade: FormzSubmissionStatus.inProgress));
        try {
          final result = await GradeService().updateGrade(event.grade);

          List<GradeModel> list = List.from(state.grade);
          if (result.isNotEmpty) {
            list[event.index] = result.first;
          }
          emit(state.copyWith(
            grade: list,
            statusGrade: FormzSubmissionStatus.success,
          ));
          event.onSuccess();
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

    on<DeleteGradeEvent>(
      (event, emit) async {
        emit(state.copyWith(statusGrade: FormzSubmissionStatus.inProgress));
        final result = await GradeService().deleteGrade(event.gradeId);

        List<GradeModel> list = List.from(state.grade);

        if (result.isNotEmpty) {
          list = result;
        } else {
          list = [];
        }

        emit(
          state.copyWith(
            grade: list,
            statusGrade: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }
}
