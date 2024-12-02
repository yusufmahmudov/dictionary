part of 'user_bloc.dart';

class UserState extends Equatable {
  final FormzSubmissionStatus statusUser;
  final List<Users> users;
  final Login? login;
  final Register? register;
  final int selUser;

  const UserState({
    this.statusUser = FormzSubmissionStatus.initial,
    this.users = const [],
    this.login,
    this.register,
    this.selUser = -1,
  });

  @override
  List<Object?> get props => [statusUser, users, selUser, login, register];

  UserState copyWith({
    FormzSubmissionStatus? statusUser,
    List<Users>? users,
    Login? login,
    Register? register,
    int? selUser,
  }) {
    return UserState(
      statusUser: statusUser ?? this.statusUser,
      users: users ?? this.users,
      login: login ?? this.login,
      register: register ?? this.register,
      selUser: selUser ?? this.selUser,
    );
  }
}
