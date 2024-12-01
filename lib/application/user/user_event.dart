part of 'user_bloc.dart';

sealed class UserEvent {}

class GetAllUsersEvent extends UserEvent {
  final int id;

  GetAllUsersEvent({required this.id});
}

class GetUserById extends UserEvent {
  final int id;

  GetUserById({required this.id});
}

class CreateUserEvent extends UserEvent {
  final UserModelG users;
  final VoidCallback onSuccess;

  CreateUserEvent({
    required this.users,
    required this.onSuccess,
  });
}

class UpdateUserEvent extends UserEvent {
  final Users users;
  final int index;
  final VoidCallback onSuccess;

  UpdateUserEvent({
    required this.users,
    required this.index,
    required this.onSuccess,
  });
}

class SelUserEvent extends UserEvent {
  final int index;

  SelUserEvent({required this.index});
}

class CheckLoginEvent extends UserEvent {
  final Login login;
  final VoidCallback onSuccess;

  CheckLoginEvent({
    required this.login,
    required this.onSuccess,
  });
}

class CheckRegisterEvent extends UserEvent {
  final Register register;
  final VoidCallback onSuccess;

  CheckRegisterEvent({
    required this.register,
    required this.onSuccess,
  });
}
