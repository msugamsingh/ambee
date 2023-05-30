part of 'user_cubit.dart';

class UserState extends Equatable {
  final User? user;
  final String? nameErrorMsg;
  final String? emailErrorMsg;

  const UserState({
    this.user,
    this.emailErrorMsg,
    this.nameErrorMsg,
  });

  UserState copyWith({
      User? user,
      String? emailErrorMsg,
      String? nameErrorMsg}) {
    return UserState(
      user: user ?? this.user,
      emailErrorMsg: emailErrorMsg ?? this.emailErrorMsg,
      nameErrorMsg: nameErrorMsg ?? this.nameErrorMsg,
    );
  }

  @override
  List<Object?> get props => [
        user,
        nameErrorMsg,
        emailErrorMsg,
      ];
}
