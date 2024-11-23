import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/data/g_model/principle_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/principle_model.dart';
import 'package:language/infrastructure/apis/principle_service.dart';

part 'principle_event.dart';
part 'principle_state.dart';

class PrincipleBloc extends Bloc<PrincipleEvent, PrincipleState> {
  PrincipleBloc() : super(const PrincipleState()) {
    on<GetPrincipleEvent>(
      (event, emit) async {
        emit(state.copyWith(statusPrinciple: FormzSubmissionStatus.inProgress));
        final result = await PrincipleService().fetchPrinciple();
        emit(
          state.copyWith(
              statusPrinciple: FormzSubmissionStatus.success,
              principle: result),
        );
      },
    );

    on<GetPrincipleByGrade>(
      (event, emit) async {
        emit(state.copyWith(statusPrinciple: FormzSubmissionStatus.inProgress));
        final result =
            await PrincipleService().fetchPrincipleByGrade(event.gradeId);
        emit(
          state.copyWith(
            statusPrinciple: FormzSubmissionStatus.success,
            principle: result,
          ),
        );
      },
    );

    on<CreatePrincipleEvent>(
      (event, emit) async {
        state.copyWith(statusPrinciple: FormzSubmissionStatus.inProgress);
        try {
          await PrincipleService().addPrinciple(event.principle, event.grade);

          state.copyWith(statusPrinciple: FormzSubmissionStatus.success);
          add(GetPrincipleEvent());
        } catch (e) {
          event.onError(e.toString());
          state.copyWith(
            statusPrinciple: FormzSubmissionStatus.failure,
          );
        }
      },
    );
  }
}
