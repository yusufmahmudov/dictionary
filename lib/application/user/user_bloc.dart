import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:language/data/g_model/users_model_g.dart';
import 'package:language/data/login.dart';
import 'package:language/data/register.dart';
import 'package:language/data/users_model.dart';
import 'package:language/infrastructure/apis/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<GetAllUsersEvent>((event, emit) async {
      emit(state.copyWith(statusUser: FormzSubmissionStatus.inProgress));
      final result = await UserService().allUserData(event.id);
      emit(
        state.copyWith(
          statusUser: FormzSubmissionStatus.success,
          users: result,
        ),
      );
    });

    on<GetUserById>((event, emit) async {
      emit(state.copyWith(statusUser: FormzSubmissionStatus.inProgress));
      final result = await UserService().fetchUserById(event.id);

      emit(
        state.copyWith(
          statusUser: FormzSubmissionStatus.success,
          users: result,
        ),
      );
    });

    on<CreateUserEvent>((event, emit) async {
      emit(state.copyWith(statusUser: FormzSubmissionStatus.inProgress));
      final result = await UserService().addUser(event.users);

      emit(
        state.copyWith(
          statusUser: FormzSubmissionStatus.success,
          users: result,
        ),
      );
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(state.copyWith(statusUser: FormzSubmissionStatus.inProgress));
      await UserService().updateUserDate(event.users);

      emit(
        state.copyWith(
          statusUser: FormzSubmissionStatus.success,
        ),
      );
    });

    on<SelUserEvent>((event, emit) async {
      emit(state.copyWith(selUser: event.index));
    });
  }
}
