import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/data/routes.dart';
import 'package:ambee/services/firebase_dynamic_link_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.context) : super(const SplashState()) {
    init(context.read<HomeCubit>());
  }

  final BuildContext context;

  Future<(double lat, double long)?> _determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition();
    return (position.latitude, position.longitude);
  }


  void init(HomeCubit cubit) async {
    final (double?, double?)? locFromDeeplink =
        await FirebaseDynamicLinkServices.initialLink(context);

    if (locFromDeeplink != null) {
      emit(state.copyWith(lat: locFromDeeplink.$1, long: locFromDeeplink.$2));
      cubit.getWeather(locFromDeeplink.$1, locFromDeeplink.$2);
    } else {
      if (state.lat != null) return;
      (double?, double?)? geo = await _determineLocation();
      emit(state.copyWith(lat: geo?.$1, long: geo?.$2));
      cubit.getWeather(geo?.$1, geo?.$2);
    }
  }

  void navigateToHome(context, homeState) {
    if (!homeState.isLoading && homeState.error == null) {
      Navigator.popAndPushNamed(context, Routes.home);
      emit(state.copyWith(listen: false));
    } else if (homeState.error != null) {
      emit(state.copyWith(listen: false, error: homeState.error));
    }
  }

  void refreshFetchData(BuildContext context) {
    var hCubit = context.read<HomeCubit>();
    hCubit.getWeather(state.lat, state.long);
    emit(state.copyWith(listen: true, error: null));
  }
}
