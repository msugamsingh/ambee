import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/data/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  void navigateToHome(context, homeState) {
    if (!homeState.isLoading && homeState.error == null) {

      Navigator.pushNamed(context, Routes.home);
      emit(state.copyWith(listen: false));
    } else if (homeState.error != null) {
      emit(state.copyWith(listen: false, error: homeState.error));
    }
  }

  void refreshFetchData(BuildContext context) {
    var hCubit = context.read<HomeCubit>();
    hCubit.getWeather();
    emit(state.copyWith(listen: true, error: null));
  }
}
