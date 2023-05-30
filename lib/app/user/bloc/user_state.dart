part of 'user_cubit.dart';

class UserState extends Equatable {
  /// The current user if exists.
  final User? user;

  /// Error message related to the user's name.
  final String? nameErrorMsg;

  /// Error message related to the user's email.
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
