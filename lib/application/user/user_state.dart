part of 'user_bloc.dart';

class UserState extends Equatable {
  final FormzSubmissionStatus statusUser;
  final List<Users> users;
  final int selUser;

  const UserState({
    this.statusUser = FormzSubmissionStatus.initial,
    this.users = const [],
    this.selUser = -1,
  });

  @override
  List<Object> get props => [statusUser, users, selUser];

  UserState copyWith({
    FormzSubmissionStatus? statusUser,
    List<Users>? users,
    int? selUser,
  }) {
    return UserState(
      statusUser: statusUser ?? this.statusUser,
      users: users ?? this.users,
      selUser: selUser ?? this.selUser,
    );
  }
}
