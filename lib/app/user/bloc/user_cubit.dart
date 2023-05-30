import 'package:ambee/app/user/model/user.dart';
import 'package:ambee/utils/helper/string_extensions.dart';
import 'package:ambee/utils/storage/storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState()) {
    getUser();
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void getUser() {
    User? user = Storage.getUser();
    if (user != null) {
      emit(state.copyWith(user: user));
      nameController.text = user.name ?? '';
      emailController.text = user.email ?? '';
    }
  }

  bool isValidated() {
    String? nameErr;
    String? emailErr;
    if (nameController.text.trim().isEmpty) {
      nameErr = 'Name can\'t be empty';
    }
    if (emailController.text.trim().isEmpty) {
      emailErr = 'Email can\'t be empty';
    }
    if (!(emailController.text.isValidEmail)) {
      emailErr = 'Invalid Email';
    }
    if (nameErr != null || emailErr != null) {
      emit(state.copyWith(
        nameErrorMsg: nameErr,
        emailErrorMsg: emailErr,
      ));
      return false;
    }
    return true;
  }

  void saveUser() {
    User user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
    );
    emit(state.copyWith(user: user));
    Storage.setUser(user);
  }
}
