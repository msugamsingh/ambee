import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/data/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.context) : super(const SplashState()) {
    fetch(context.read<HomeCubit>());
  }
  final BuildContext context;

  // Future<void> _checkService() async {
  //   final serviceEnabledResult = await isGPSEnabled();
  //   _serviceEnabled = serviceEnabledResult;
  // }

  Future<(double lat, double long)?> _determinePosition() async {
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

  // Future<(double? lat, double? long)?> splash() async {
  //   final permissionGrantedResult = await getPermissionStatus();
  //   if (permissionGrantedResult == PermissionStatus.authorizedWhenInUse ||
  //       permissionGrantedResult == PermissionStatus.authorizedAlways) {
  //     try {
  //       final locationResult = await getLocation(settings: LocationSettings(accuracy: LocationAccuracy.low));
  //       double? lat = locationResult.latitude;
  //       double? long = locationResult.longitude;
  //       return (lat, long);
  //     } catch (e) {
  //       print(e);
  //       return null;
  //     }
  //   } else if (permissionGrantedResult == PermissionStatus.notDetermined) {
  //     final permissionRequestedResult = await requestPermission();
  //     print(permissionRequestedResult);
  //     if (permissionRequestedResult == PermissionStatus.authorizedWhenInUse ||
  //         permissionRequestedResult == PermissionStatus.authorizedAlways) {
  //       try {
  //         final locationResult = await getLocation(settings: LocationSettings(accuracy: LocationAccuracy.low));
  //         double? lat = locationResult.latitude;
  //         double? long = locationResult.longitude;
  //         return (lat, long);
  //       } catch (e) {
  //         print(e);
  //         return null;
  //       }
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     // default lat long for bangalore is set in [HomeCubit]
  //     return null;
  //   }
  // }

  void fetch(HomeCubit cubit) async {
    if (state.lat != null) return;
    (double?, double?)? geo = await _determinePosition();
    print(geo);
    print('lol');
    emit(state.copyWith(lat: geo?.$1, long: geo?.$2));
    cubit.getWeather(geo?.$1, geo?.$2);
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
