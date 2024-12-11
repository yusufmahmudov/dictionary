import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/data/g_model/users_model_g.dart';
import 'package:language/data/login.dart';
import 'package:language/data/register.dart';
import 'package:language/data/users_model.dart';
import 'package:language/infrastructure/apis/user_service.dart';
import 'package:language/infrastructure/repository/storage_repository.dart';

import '../../assets/constants/storage_keys.dart';

part 'user_event.dart';
part 'user_state.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  loading,
  cancelLoading,
}

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
      int? id = StorageRepository.getInt(StorageKeys.USERID);
      if (id == 0) {
        emit(state.copyWith(
          statusAuth: AuthenticationStatus.unauthenticated,
        ));
      } else {
        final result = await UserService().fetchUserById(id);

        if (result.isEmpty) {}

        emit(
          state.copyWith(
            statusAuth: AuthenticationStatus.authenticated,
            statusUser: FormzSubmissionStatus.success,
            users: result,
          ),
        );
      }
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
      event.onSuccess();
    });

    on<SelUserEvent>((event, emit) async {
      emit(state.copyWith(selUser: event.index));
    });

    on<LogOutUserEvent>(
      (event, emit) async {
        emit(state.copyWith(statusUser: FormzSubmissionStatus.inProgress));
        await StorageRepository.deleteInt(StorageKeys.USERID);

        emit(
          state.copyWith(
            statusAuth: AuthenticationStatus.unauthenticated,
            statusUser: FormzSubmissionStatus.success,
          ),
        );
      },
    );

    on<CheckLoginEvent>((event, emit) async {
      emit(state.copyWith(statusUser: FormzSubmissionStatus.inProgress));

      try {
        final result = await UserService().checkLogin(event.login);

        if (result.success) {
          emit(
            state.copyWith(
              statusAuth: AuthenticationStatus.authenticated,
              statusUser: FormzSubmissionStatus.success,
              login: result,
            ),
          );
          await StorageRepository.putInt(
            StorageKeys.USERID,
            result.id,
          );
        } else if (!result.success && result.id == -1) {
          // telefon raqam mavjud emas
          emit(
            state.copyWith(
              statusUser: FormzSubmissionStatus.failure,
              login: result,
            ),
          );
        } else if (!result.success) {
          // Parol mos kelmadi
          emit(
            state.copyWith(
              statusUser: FormzSubmissionStatus.canceled,
              login: result,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(statusUser: FormzSubmissionStatus.failure));
      }
    });

    on<CheckRegisterEvent>((event, emit) async {
      emit(state.copyWith(statusUser: FormzSubmissionStatus.inProgress));

      try {
        final result = await UserService().checkRegister(event.register);

        if (result.success) {
          emit(
            state.copyWith(
              statusAuth: AuthenticationStatus.authenticated,
              statusUser: FormzSubmissionStatus.success,
              register: result,
            ),
          );
          await StorageRepository.putInt(
            StorageKeys.USERID,
            result.id,
          );
        } else if (!result.success && result.id == -2) {
          // serverdan qaytgan xatolik
          emit(
            state.copyWith(
              statusUser: FormzSubmissionStatus.failure,
              register: result,
            ),
          );
        } else if (result.id == -1) {
          // Bu raqam allaqachon mavjud
          emit(
            state.copyWith(
              statusUser: FormzSubmissionStatus.canceled,
              register: result,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(statusUser: FormzSubmissionStatus.failure),
        );
      }
    });
  }
}
