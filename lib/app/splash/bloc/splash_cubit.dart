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

  // Method: Determines the current device location using Geolocator package
  Future<(double lat, double long)?> _determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // check if location service enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    // check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // do nothing, defaults coordinates already exists in HomeCubit
      return null;
    }

    // todo: Future Improvements - if user has given the permission
    // and currently disabled the location service, pick location co-ordinates
    // from storage

    final position = await Geolocator.getCurrentPosition();

    // return coordinates record
    return (position.latitude, position.longitude);
  }


  // Method: Initializes the SplashCubit and retrieves the location for weather data
  void init(HomeCubit cubit) async {

    // check if co-ordinates available from some deeplink
    final (double?, double?)? locFromDeeplink =
        await FirebaseDynamicLinkServices.initialLink(context);

    if (locFromDeeplink != null) {
      emit(state.copyWith(lat: locFromDeeplink.$1, long: locFromDeeplink.$2));
      cubit.getWeather(locFromDeeplink.$1, locFromDeeplink.$2);
    } else {
      if (state.lat != null) return;

      // get coordinates from the current user location
      (double?, double?)? geo = await _determineLocation();
      emit(state.copyWith(lat: geo?.$1, long: geo?.$2));
      cubit.getWeather(geo?.$1, geo?.$2);
    }
  }

  // Method: Navigates to the home screen based on the provided HomeState
  void navigateToHome(context, HomeState homeState) {
    if (!homeState.isLoading && homeState.error == null) {
      Navigator.popAndPushNamed(context, Routes.home);
      emit(state.copyWith(listen: false));
    } else if (homeState.error != null) {
      emit(state.copyWith(listen: false, error: homeState.error));
    }
  }

  // Method: Refreshes the weather data by calling the getWeather method in HomeCubit
  void refreshFetchData(BuildContext context) {
    var hCubit = context.read<HomeCubit>();
    emit(state.copyWith(listen: true, error:  null));
    hCubit.getWeather(state.lat, state.long);
  }
}
