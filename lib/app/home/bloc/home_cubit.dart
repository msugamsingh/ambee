import 'dart:async';

import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/app/home/repo/home_repo.dart';
import 'package:ambee/data/constants.dart';
import 'package:ambee/data/network/network_error_messages.dart';
import 'package:ambee/data/response/repo_response.dart';
import 'package:ambee/utils/helper/my_logger.dart';
import 'package:ambee/utils/helper/string_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geocoding/geocoding.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final HomeRepository _repo = HomeRepository();

  final FlutterGooglePlacesSdk _places = FlutterGooglePlacesSdk(GOOGLE_API_KEY);

  final locationController = TextEditingController();

  final PlaceTypeFilter _placeTypeFilter = PlaceTypeFilter.CITIES;

  Timer? _debounce;

  Future<void> getWeather(
    double? lat,
    double? lon, {
    bool force = false,
    bool updateLocation = true,
  }) async {
    if (state.isLoading && !force) return;
    emit(
      state.copyWith(isLoading: true, error: null, lat: lat, lon: lon),
    );

    RepoResponse<WeatherData> response = await _repo.getWeather(
      lat: lat ?? state.lat,
      lon: lon ?? state.lon,
    );
    List<Placemark>? placemarks;
    if (updateLocation) {
      placemarks = await placemarkFromCoordinates(state.lat, state.lon);
    }

    Log.wtf(placemarks);

    if (response.error == null && response.data != null) {
      Log.i(response.data?.toJson());
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          currentWeather: response.data?.current?.weather?.first,
          weatherData: response.data,
          location:
              updateLocation ? (placemarks?.first.locality ?? 'Unknown') : null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          error: response.error?.message ?? ErrorMessages.somethingWentWrong,
        ),
      );
    }
  }

  void setLatLon(lat, lon) => emit(state.copyWith(lat: lat, lon: lon));

  void offPredictLoading() => emit(state.copyWith(loadingPredictions: false));

  void cancelDebounce() => _debounce?.cancel();

  void predict(String s) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (s.isNullOrEmpty) {
        emit(state.copyWith(
            locationPredictions: const [], loadingPredictions: false));
        return;
      }
      try {
        final result = await _places.findAutocompletePredictions(
          s,
          countries: ['in'],
          placeTypeFilter: _placeTypeFilter,
          newSessionToken: false,
        );
        emit(
          state.copyWith(
            locationPredictions: result.predictions,
            loadingPredictions: false,
          ),
        );
      } catch (e) {
        Log.e(e);
      } finally {
        emit(state.copyWith(loadingPredictions: false));
      }
    });
    emit(state.copyWith(loadingPredictions: true));
  }

  Future<void> onPredictionSelect(String title) async {
    if (title.isNullOrEmpty) return;
    // location from prediction
    String locality = title.split(',').first;
    emit(state.copyWith(location: locality, isLoading: true));
    List<Location> locations = await locationFromAddress(title);
    final Location location = locations.first;
    await getWeather(
      location.latitude,
      location.longitude,
      force: true,
      updateLocation: false,
    );
    locationController.text = '';
  }

  void onHourlyItemTap(int index) {
    if (index == state.selectedHourIndex) {
      emit(
        state.copyWith(
          selectedHourIndex: -1,
          currentWeather: state.weatherData?.current?.weather?.first,
          selectedHourData: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedHourIndex: index,
          currentWeather: state.weatherData?.hourly?[index].weather?.first,
          selectedHourData: state.weatherData?.hourly?[index],
        ),
      );
    }
  }

  String getWindSpeed() {
    return '${(state.selectedHourIndex >= 0 ? state.selectedHourData?.windSpeed : state.weatherData?.current?.windSpeed) ?? ''}'
        ' m/s';
  }

  String? getTemp() {
    return state.selectedHourIndex >= 0
        ? state.selectedHourData?.temp?.toString()
        : state.weatherData?.current?.temp?.toString();
  }

  String getHumidity() {
    return '${(state.selectedHourIndex >= 0 ? state.selectedHourData?.humidity : state.weatherData?.current?.humidity) ?? ''}'
        '%';
  }

  String getRainPop() {
    return '${((state.selectedHourData?.pop) ?? 0) * 100}%';
  }

  String getUVI() {
    return (state.weatherData?.current?.uvi?.toString()) ?? '';
  }

  getLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(state.lat, state.lon);
    return placemarks.first.name ?? 'unknow';
  }
}
